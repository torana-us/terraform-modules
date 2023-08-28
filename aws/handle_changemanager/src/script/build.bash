#!/bin/bash

current="$(cd "$(dirname "$0")" && pwd)"
binary_name="bootstrap"

cd "$current/.." || exit 1
GOOS=linux CGO_ENABLED=0 go build -ldflags "-s -w" -o "$binary_name" .
zip "$binary_name.zip" "$binary_name"
rm "$binary_name"
