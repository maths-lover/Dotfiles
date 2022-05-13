#!/usr/bin/env bash

echo "GOPATH set by fish already"
echo "GOBIN set by fish already"

echo "+-------------------------------------------------------+"
echo "|                  Go tools installation                |"
echo "+-------------------------------------------------------+"

# Install packages required for neovim and stuff
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.45.2
go install cuelang.org/go/cmd/cue@latest
