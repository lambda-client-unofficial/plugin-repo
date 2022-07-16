#!/bin/bash

exitmsg() {
  echo "$1" > /dev/stderr
  exit 1
}

[ -z "$1" ] && exitmsg "No directory argument provided." 

source=$(cat "$1/source")
build="$1-build"
git clone "$source" "$build" || exitmsg "Failed to clone repository from $source to $build"
cd "$1-build" || exitmsg "Failed to change cd to $build."

"../$1/build"

cp -R "build/libs" ../build
