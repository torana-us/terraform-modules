package main

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"os"
	"strings"
	"time"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	"github.com/aws/aws-sdk-go-v2/service/ssm/types"
	"github.com/aws/aws-sdk-go/aws"
	_ "github.com/go-sql-driver/mysql"
	"go.uber.org/zap"
)

var ssmService *ssm.Client

func init() {
	level := os.Getenv("LOG_LEVEL")
	zapConfig := zap.NewProductionConfig()
	atomicLevel := zap.NewAtomicLevel()

	switch level {
	case "info":
		atomicLevel.SetLevel(zap.InfoLevel)
	case "warn":
		atomicLevel.SetLevel(zap.WarnLevel)
	case "error":
		atomicLevel.SetLevel(zap.ErrorLevel)
	case "debug":
		atomicLevel.SetLevel(zap.DebugLevel)
	}

	zapConfig.Level = atomicLevel

	logger, err := zapConfig.Build()

	if err != nil {
		log.Fatal(err)
	}

	zap.ReplaceGlobals(logger)

	cfg, err := config.LoadDefaultConfig(context.TODO())

	if err != nil {
		log.Fatalf("failed to load configuration, %v", err)
	}

	ssmService = ssm.NewFromConfig(cfg)
}

func main() {
	lambda.Start(HandleRequest)
}

type ActionType string

const (
	ADD_PERMISSION    ActionType = "add_permission"
	DELETE_PERMISSION ActionType = "delete_permission"
)

type SNSEventMessage struct {
	User   string     `json:"user"`
	Action ActionType `json:"action"`
}

func getMessage(event events.SNSEvent, v *SNSEventMessage) error {
	for _, r := range event.Records {
		err := json.Unmarshal([]byte(r.SNS.Message), &v)
		if err != nil {
			return err
		}
	}
	return nil
}

var (
	isTest = isTestExecution()
)

func isTestExecution() bool {
	for _, arg := range os.Args {
		if strings.HasPrefix(arg, "-test.") {
			return true
		}
	}
	return false
}

type DsnGetter interface {
	Get() (string, error)
}

type GetDsnFunc func() (string, error)

func (f GetDsnFunc) Get() (string, error) {
	return f()
}

func MakeDsnGetter() DsnGetter {
	var f GetDsnFunc

	if isTest {
		f = func() (string, error) {
			dsn := os.Getenv("dsn")
			return dsn, nil
		}
	} else {
		parameterName := os.Getenv("parameter_name")
		f = func() (string, error) {
			input := &ssm.GetParameterInput{
				Name:           aws.String(parameterName),
				WithDecryption: aws.Bool(true),
			}

			output, err := ssmService.GetParameter(context.TODO(), input)
			if err != nil {
				return "", err
			}

			return *output.Parameter.Value, nil
		}
	}

	return f
}

func extractDbName(s string) string {
	at := strings.Index(s, "/")
	if at == -1 {
		return ""
	}

	return s[at+1:]
}

func HandleRequest(ctx context.Context, event events.SNSEvent) error {
	l := zap.L().Sugar()

	var message SNSEventMessage
	l.Debug("start getMessage")
	getMessage(event, &message)
	l.Debug(fmt.Sprintf("user: %s, action: %s", message.User, message.Action))

	l.Debug("get dsn")
	dsn, err := MakeDsnGetter().Get()

	if err != nil {
		return err
	}

	l.Debug("sql Open")
	db, err := sql.Open("mysql", dsn)

	if err != nil {
		return err
	}

	defer db.Close()

	userName := addPrefix(extractUsername(message.User))
	dbName := extractDbName(dsn)

	switch message.Action {
	case ADD_PERMISSION:
		l.Debug("create user")
		password, err := createUser(db, userName, dbName)
		if err != nil {
			return err
		}
		l.Debug("新しいユーザーを作成しました")
		l.Debug("put db info")
		err = putDbInfo(userName, password, dbName)
		if err != nil {
			return err
		}
	case DELETE_PERMISSION:
		l.Debug("delete user")
		err = deleteUser(db, userName)
		if err != nil {
			return err
		}
		l.Debug("ユーザーを削除しました")
	}

	return nil
}

func existUser(db *sql.DB, userName string) (bool, error) {
	var count int
	err := db.QueryRow("SELECT count(*) FROM mysql.user WHERE USER = ?", userName).Scan(&count)

	if err != nil {
		return false, err
	}

	return (count != 0), nil
}

func addPrefix(s string) string {
	return fmt.Sprintf("c_manager_%s", s)
}

func extractUsername(email string) string {
	at := strings.Index(email, "@")
	if at == -1 {
		return email
	}

	return email[:at]
}

func createUser(db *sql.DB, userName string, dbName string) (string, error) {
	l := zap.L().Sugar()

	l.Debug(fmt.Sprintf("name %s", userName))

	err = deleteUser(db, userName)
	if err != nil {
		return err
	}

	l.Debug("create user")
	password := generateRandomPassword(20)
	_, err = db.Exec(fmt.Sprintf("CREATE USER '%s'@'%%' IDENTIFIED BY '%s'", userName, password))

	if err != nil {
		return "", err
	}

	l.Debug("grant user")
	_, err = db.Exec(fmt.Sprintf("GRANT ALL PRIVILEGES ON %s.* TO '%s'@'%%'", dbName, userName))
	if err != nil {
		log.Fatal(err)
	}

	return password, nil
}

func deleteUser(db *sql.DB, userName string) error {
	exist, err := existUser(db, userName)

	if err != nil {
		return err
	}

	if !exist {
		return nil
	}

	_, err = db.Exec(fmt.Sprintf("DROP user '%s'@'%%'", userName))

	if err != nil {
		return err
	}

	return nil
}

const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

func generateRandomPassword(length int) string {
	seededRand := rand.New(rand.NewSource(time.Now().UnixNano()))

	password := make([]byte, length)
	for i := range password {
		password[i] = charset[seededRand.Intn(len(charset))]
	}

	return string(password)
}

func putDbInfo(userName string, password string, dbName string) error {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	if err != nil {
		return err
	}

	client := ssm.NewFromConfig(cfg)

	parameterName := fmt.Sprintf("/autogenerate/%s/%s", userName, dbName)
	parameterValue := password

	input := &ssm.PutParameterInput{
		Name:      aws.String(parameterName),
		Value:     aws.String(parameterValue),
		Type:      types.ParameterTypeSecureString,
		Overwrite: aws.Bool(true),
	}

	_, err = client.PutParameter(context.TODO(), input)
	if err != nil {
		return err
	}

	return nil
}
