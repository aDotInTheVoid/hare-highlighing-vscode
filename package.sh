#!/bin/bash
set -eoxu pipefail

cd "$(dirname "$0")"

version=$(jq -r .version package.json)
rm -f hare-highlighting-$version.vsix
vsce package

zipinfo -1 ./hare-highlighting-*.vsix > contents.txt

c_diff=$(git diff contents.txt)

if [[ -n "$c_diff" ]]; then
  echo "contents.txt is not up to date"
  exit 1
fi
