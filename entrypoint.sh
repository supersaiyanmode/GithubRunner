#!/bin/bash

pushd /actions-runner

if [[ -z "${GITHUB_TOKEN}" ]]; then
  echo "GITHUB_TOKEN required." 1>&2
  exit 1
fi

if ! ./config.sh --url https://github.com/supersaiyanmode/GithubRunner --token $GITHUB_TOKEN; then
  echo "Failed to connect to GitHub, exiting .." 1>&2
  exit 1
fi

./run.sh
