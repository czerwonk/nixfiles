#!/bin/bash
set -e

home-manager switch --flake "$HOME/.nixfiles#$1"
