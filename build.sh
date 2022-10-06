#!/bin/bash

exitmsg() {
  echo "$1" > /dev/stderr
  exit 1
}

[ ! -d "build" ] && mkdir build
[ -z "$1" ] && exitmsg "No directory argument provided." 

source=$(cat "plugins/$1/source")
IFS=" " read -r -a version <<< "$(cat "plugins/$1/version")"
build="$1-build"
echo "🔄 $build"
git clone -q "$source" "$build" || exitmsg "Failed to clone repository from $source to $build"
cd "$build" || exitmsg "Failed to change cd to $build."

if ! [ "$2" = "--git" ]; then
  git checkout -q "${version[0]}" || exitmsg "Failed to change version to ${version[0]}"
else
  echo "🐉 $build"
fi

echo "🔨 $1"
chmod +x "../plugins/$1/build"
"../plugins/$1/build" || exitmsg "Failed to build $1."

find build/libs/*.jar | while IFS= read -r s; do mv "$s" "build/libs/$1-${version[0]}.jar"; done

echo "📦 $1"
cp "build/libs/$1-${version[0]}.jar" "../build/"
