#!/bin/bash

current="$(cd "$(dirname "$0")" && pwd)"
binary_name="runner"

cd "$current/.." || exit 1
GOOS=linux go build -o "$binary_name" .
zip "$binary_name.zip" "$binary_name"
rm "$binary_name"
