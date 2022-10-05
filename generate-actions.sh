#!/bin/bash

plugins="$(ls -m plugins)"

cat << EOF > .github/workflows/gradle.yml
name: Build and upload all plugins

on: workflow_dispatch

permissions:
  contents: read

jobs:
  plugins_matrix:
    strategy:
      matrix:
        plugins: [$plugins]
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-java@v3
      with:
        java-version: '8'
        distribution: 'temurin'
    - run: |
        ./build.sh \${{ matrix.plugins }}
    - uses: actions/upload-artifact@v3.1.0
      with:
        path: build
EOF

cat << EOF > .github/workflows/check.yml
name: Check if plugin versions are correct. 

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

  workflow_dispatch:

jobs:
  plugins_matrix:
    strategy:
      matrix:
        plugins: [$plugins]
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - run: |
        ./check-version.sh \${{ matrix.plugins }}
EOF

git diff

