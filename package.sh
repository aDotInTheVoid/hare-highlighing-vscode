#!/bin/bash
set -eoxu pipefail

cd "$(dirname "$0")"

if [[ -z ${VSCE_PAT+secret} ]]; then
    echo "VSCE_PAT is not set"
    exit 1
fi
if [[ -z ${OVSX_PAT+secret} ]]; then
    echo "OVSX_PAT is not set"
    exit 1
fi
if [[ -z $1 ]]; then
    echo "Usage: $0 --publish-vsce | --publish-ovsx | --dry-run"
    exit 1
fi


version=$(jq -r .version package.json)
vsix=hare-highlighting-"$version".vsix

rm -f $vsix
vsce package

zipinfo -1 $vsix > contents.txt

c_diff=$(git diff contents.txt)

if [[ -n "$c_diff" ]]; then
  echo "contents.txt is not up to date"
  exit 1
fi


c_diff=$(git status --porcelain)
if [[ -n "$c_diff" ]]; then
  echo "git status is not clean"
  exit 1
fi


case $1 in
    --publish-vsce)
        vsce publish
        ;;
    --publish-ovsx)
        ovsx publish $vsix
        ;;
    --dry-run)
        echo "Nothing to do"
        ;;
esac


