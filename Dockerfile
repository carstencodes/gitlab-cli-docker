ARG PYTHON_VERSION
ARG ALPINE_VERSION

FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}

ARG GITLAB_CLI_VERSION

ADD build-gitlab-cfg /bin

RUN apk add --no-cache --virtual .build-deps alpine-sdk python3-dev libffi-dev openssl-dev \
    && pip install --no-input --no-cache-dir --upgrade python-gitlab==${GITLAB_CLI_VERSION} \
    && apk del .build-deps \
    && adduser -h /home/gitlab-cli -s /bin/sh -u 1000 -D gitlab-cli \
    && passwd -u gitlab-cli \
    && chmod a+x /bin/build-gitlab-cfg
    
WORKDIR /home/gitlab-cli

USER gitlab-cli

CMD ["sh"] 
