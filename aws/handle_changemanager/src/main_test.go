package main

import (
	"testing"
)

// func TestHandleRequest(t *testing.T) {
// 	os.Setenv("dsn", fmt.Sprintf("%s:%s@tcp(%s)/example_database", "root", "example_password", "127.0.0.1"))

// 	event := events.SNSEvent{
// 		Records: []events.SNSEventRecord{
// 			{SNS: events.SNSEntity{
// 				Message: `{"user": "bcd","action": "add_permission"}`,
// 			},
// 			},
// 		},
// 	}

// 	if err := HandleRequest(context.Background(), event); err != nil {
// 		t.Fatal(err)
// 	}
// }

func TestExtractUsername(t *testing.T) {
	cases := []struct {
		email  string
		expect string
	}{
		{"hoge@google.com", "hoge"},
		{"fuga@example.org", "fuga"},
		{"user+alias@domain.com", "user+alias"},
		{"username", "username"},
		{"", ""},
	}

	for _, c := range cases {
		actual := extractUsername(c.email)
		if actual != c.expect {
			t.Errorf("Expected: %s, got: %s", c.expect, actual)
		}
	}
}

func TestExtractDatabaseName(t *testing.T) {
	testCases := []struct {
		name             string
		connectionString string
		expected         string
	}{
		{
			name:             "正常な接続文字列",
			connectionString: "user:pass@tcp(localhost)/example_database",
			expected:         "example_database",
		},
		{
			name:             "データベース名がない接続文字列",
			connectionString: "user:pass@tcp(localhost)/",
			expected:         "",
		},
		{
			name:             "スラッシュがない接続文字列",
			connectionString: "user:pass@tcp(localhost)",
			expected:         "",
		},
	}

	for _, tc := range testCases {
		t.Run(tc.name, func(t *testing.T) {
			actual := extractDbName(tc.connectionString)
			if actual != tc.expected {
				t.Errorf("expected: %s, actual: %s", tc.expected, actual)
			}
		})
	}
}
