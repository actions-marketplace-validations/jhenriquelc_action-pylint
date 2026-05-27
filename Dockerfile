FROM konstruktoid/alpine:latest@sha256:8611a9d532debde54c06f18ad06d8b6760cf0b961dc943adac4590852ff3add2

LABEL "com.github.actions.name"="jhenriquelc Python linting"
LABEL "com.github.actions.description"="Python linting using ruff and ty"
LABEL "com.github.actions.icon"="bell"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/jhenriquelc/action-pylint"
LABEL "homepage"="https://github.com/jhenriquelc/action-pylint"
LABEL "maintainer"="João H. L. Corrêa <jhenriquelc@users.noreply.github.com>"

COPY requirements.txt /requirements.txt

ENV PATH="${PATH}:/root/.local/bin"

RUN apk --no-cache add gcc musl-dev python3 python3-dev py3-pip && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    python3 -m pip install --break-system-packages --no-cache-dir --upgrade pipx && \
    for p in $(grep -v '^#' /requirements.txt); do pipx install "${p}"; done && \
    apk del gcc musl-dev python3-dev && \
    rm -rf /var/cache/apk/

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
