#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

export PATH=$PATH:/tmp/bin
mkdir -p /tmp/bin

export GITHUB_USER=$(cat /usr/local/ci-secrets/redhat-appstudio-qe/github-user)
export GITHUB_TOKEN=$(cat /usr/local/ci-secrets/redhat-appstudio-qe/github-token)
export QUAY_TOKEN=$(cat /usr/local/ci-secrets/redhat-appstudio-qe/quay-token)

git config --global user.name "redhat-appstudio-qe-bot"
git config --global user.email redhat-appstudio-qe-bot@redhat.com

mkdir -p ${HOME}/creds
GIT_CREDS_PATH="${HOME}/creds/file"
git config --global credential.helper "store --file ${GIT_CREDS_PATH}"
echo "https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com" > ${GIT_CREDS_PATH}

/bin/bash .ci/oci-e2e-deployment.sh