#!/usr/bin/env bash
# Baseline environment install step.
#
# This repository does not yet contain application code, so there are no
# project dependencies to install. This script verifies that the expected
# toolchains are present on the base image and is safe to run repeatedly
# (idempotent). When application code is added, extend this script with the
# real dependency-install commands (e.g. `npm ci`, `pip install -r ...`,
# `go mod download`, `cargo fetch`) guarded so it stays idempotent.
set -euo pipefail

echo "== Baseline toolchain check =="

check() {
  local name="$1"
  shift
  if command -v "$1" >/dev/null 2>&1; then
    printf '  %-8s %s\n' "$name:" "$("$@" 2>&1 | head -n 1)"
  else
    printf '  %-8s not found\n' "$name:"
  fi
}

check "node"   node --version
check "npm"    npm --version
check "python" python3 --version
check "pip"    pip3 --version
check "go"     go version
check "rustc"  rustc --version
check "cargo"  cargo --version
check "java"   java -version
check "git"    git --version

echo "== Baseline install complete =="
