#!/bin/bash

plugins=(plugins/*)
for plugin in "${plugins[@]}"
do
    source=$(cat "$plugin/source")
    repo=${source#"https://github.com/"}
    repo=${repo%".git"}
    IFS=" " read -r -a version <<<"$(cat "$plugin/version")"

    remote_version="$(curl -s "https://raw.githubusercontent.com/$repo/master/src/main/resources/plugin_info.json" | jq .min_api_version | tr -d '"')"

    if [ "$remote_version" = "${version[1]}" ]; then
        echo "✔ $plugin"
    else
        echo >&2 "✖ $plugin"
        echo "::warning file=$plugin/source,line=1::Incorrect lambda api version set."
    fi
done
