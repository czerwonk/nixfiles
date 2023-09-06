#!/bin/bash
set -e

pushd "$HOME/.nixfiles"
git pull
home-manager switch --flake "#$1"
popd
