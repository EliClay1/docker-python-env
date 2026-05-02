FROM quay.io/jupyter/base-notebook:latest

USER root

RUN apt-get -qq update \
 && apt-get -qq install -y --no-install-recommends \
    netcat-openbsd tmux vim \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    nbclassic \
    scapy \
    pwntools \
    requests \
    mitmproxy \
    jupyterthemes

RUN mkdir -p /home/jovyan/.jupyter/custom \
    /opt/custom-assets/images \
    /usr/local/bin/start-notebook.d

COPY images/ /opt/custom-assets/images/

RUN printf '%s\n' \
'#!/bin/sh' \
'set -eu' \
'' \
'NBCLASSIC_IMG_DIR="/opt/conda/lib/python3.11/site-packages/nbclassic/static/base/images"' \
'JSERVER_FAVICON_DIR="/opt/conda/lib/python3.11/site-packages/jupyter_server/static/favicons"' \
'ASSET_SRC="/opt/custom-assets/images"' \
'' \
'if [ -d "$ASSET_SRC" ]; then' \
'  mkdir -p "$NBCLASSIC_IMG_DIR" "$JSERVER_FAVICON_DIR"' \
'  cp -f "$ASSET_SRC"/* "$NBCLASSIC_IMG_DIR"/ 2>/dev/null || true' \
'  cp -f "$ASSET_SRC"/* "$JSERVER_FAVICON_DIR"/ 2>/dev/null || true' \
'fi' \
'' \
'chown -R ${NB_UID}:${NB_GID} /home/jovyan/.jupyter /home/jovyan/work || true' \
> /usr/local/bin/start-notebook.d/10-copy-custom-assets.sh \
 && chmod +x /usr/local/bin/start-notebook.d/10-copy-custom-assets.sh

USER jovyan

RUN mkdir -p /home/jovyan/.jupyter/custom /home/jovyan/work