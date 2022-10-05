#!/bin/bash

plugins=(plugins/*)
for plugin in "${plugins[@]}"; do
    source=$(cat "$plugin/source")
    repo=${source#"https://github.com/"}
    repo=${repo%".git"}
    IFS=" " read -r -a version <<<"$(cat "$plugin/version")"

    remote_version="$(curl -s "https://raw.githubusercontent.com/$repo/master/src/main/resources/plugin_info.json" | jq .min_api_version | tr -d '"')"
    releases="$(curl -s -H "Authorization: Bearer $API_TOKEN" "https://api.github.com/repos/$repo/releases" | jq .[0].tag_name | tr -d '"')"

    plugin=${plugin#"plugins/"}
    if [ "$remote_version" = "${version[1]}" ]; then
        echo "✔ $plugin (1/2)"
    else
        echo "::warning::$plugin has lambda api version ${version[1]} set, expected $remote_version"
    fi

    if [ "$releases" = "null" ]; then
        if [ "${version[0]}" = "HEAD" ]; then
            echo "✔ $plugin (2/2)"
        else 
            echo "::warning::$plugin's version is set to ${version[0]} , expected HEAD"
        fi
    else
        if [ "${version[0]}" = "$releases" ]; then
            echo "✔ $plugin (2/2)"
        else
            echo "::warning::$plugin's version is set to ${version[0]}, expected $releases"
        fi
    fi
done
