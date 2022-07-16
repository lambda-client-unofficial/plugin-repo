#!/bin/bash

cd plugins || exit 0
plugins=(*)

echo "Contained plugins:"
for plugin in "${plugins[@]}"
do
  source="$(cat "$plugin/source")"
  echo "- [$plugin](${source%".git"})"
done
