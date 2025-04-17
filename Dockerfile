ARG OS_BASE_IMAGE
ARG PLATFORM

FROM --platform=$PLATFORM $OS_BASE_IMAGE

RUN pacman -Syy --noconfirm
RUN pacman --noconfirm -S curl tar zip git docker base-devel cmake wget python jq

COPY entrypoint.sh /.
RUN chmod +x /entrypoint.sh

RUN mkdir /actions-runner
WORKDIR /actions-runner

RUN curl -o actions-runner.tar.gz -L https://github.com/actions/runner/releases/download/v2.323.0/actions-runner-linux-arm64-2.323.0.tar.gz
RUN tar xzf actions-runner.tar.gz
RUN rm actions-runner.tar.gz

RUN useradd -ms /bin/bash actionsrunner
RUN chown -R actionsrunner:actionsrunner /actions-runner
USER actionsrunner

CMD ["/entrypoint.sh"]
