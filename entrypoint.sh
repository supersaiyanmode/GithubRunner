#!/bin/bash

pushd /actions-runner

if [[ -z "${GITHUB_TOKEN}" ]]; then
  echo "GITHUB_TOKEN required." 1>&2
  exit 1
fi

if [[ -z "${GITHUB_REPO}" ]]; then
  echo "GITHUB_REPO required." 1>&2
  exit 1
fi

echo "Using Github token: ${GITHUB_TOKEN:0:2}..${GITHUB_TOKEN: -2} for ${GITHUB_REPO}"

if ! ./config.sh --url "${GITHUB_REPO}" --token $GITHUB_TOKEN; then
  echo "Failed to connect to GitHub, exiting .." 1>&2
  exit 1
fi

./run.sh
