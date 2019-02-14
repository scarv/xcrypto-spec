#!/bin/bash

export REPO_HOME="${PWD}"
export TEXMFLOCAL="${TEXMFLOCAL}:${REPO_HOME}/ext/texmf"

texhash
