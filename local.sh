#!/bin/bash

function build {
  rm -rf /tmp/docker-build
  mkdir -p /tmp/docker-build/
  cp Dockerfile /tmp/docker-build/.
  cp entrypoint.sh /tmp/docker-build/.

  pushd /tmp/docker-build

  docker build --build-arg OS_BASE_IMAGE=archlinux \
      --build-arg PLATFORM=amd64 \
      -t github_runner_local .
}

function run {
  docker rm --force github_runner

  if [[ -z "${GITHUB_TOKEN}" ]]; then
    echo "GITHUB_TOKEN required." 1>&2
    exit 1
  fi

  docker run -e GITHUB_TOKEN=$GITHUB_TOKEN --name github_runner github_runner_local
}

function debug {
  docker rm --force github_debug
  docker run --name github_debug github_runner_local tail -f /dev/null
}

function bash {
  docker exec -it github_debug /bin/bash
}

function kill_debug {
  docker kill github_debug
}

$1
