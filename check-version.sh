#!/bin/bash

source=$(cat "plugins/$1/source")
repo=${source#"https://github.com/"}
repo=${repo%".git"}
IFS=" " read -r -a version <<< "$(cat "plugins/$1/version")"

remote_version="$(curl -s "https://raw.githubusercontent.com/$repo/master/src/main/resources/plugin_info.json" | jq .min_api_version | tr -d '"')"

if [ "$remote_version" = "${version[1]}" ]; then
    echo "✔ $1" && exit 0
else
    >&2 echo "✖ $1" && exit 1
fi
