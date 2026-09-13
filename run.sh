#!/bin/bash
set -e

FLEX_BIN="./tools/flex.exe"
GPP_BIN="/c/msys64/mingw64/bin/g++.exe"
export PATH="/c/msys64/mingw64/bin:$PATH"

"$FLEX_BIN" -o lexer.cpp lexer.l
"$GPP_BIN" lexer.cpp -o my_scanner.exe

./my_scanner.exe code.m > result.txt 2> errors.txt

echo "Done"
start notepad result.txt
start notepad errors.txt