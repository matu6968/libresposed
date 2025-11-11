#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATCH_FILE="${ROOT_DIR}/patch-java-requirement.patch"
SERVICE_DIR="${ROOT_DIR}/libxposed/service"
API_DIR="${ROOT_DIR}/libxposed/api"

if [[ ! -x "${ROOT_DIR}/gradlew" ]]; then
    echo "Gradle wrapper not found or not executable at ${ROOT_DIR}/gradlew"
    exit 1
fi

if [[ ! -d "${SERVICE_DIR}" || ! -d "${API_DIR}" ]]; then
    echo "libxposed repositories not found. Ensure submodules are configured."
    exit 1
fi

if [[ ! -f "${PATCH_FILE}" ]]; then
    echo "Patch file missing: ${PATCH_FILE}"
    exit 1
fi

echo "[1/5] Updating git submodules..."
git -C "${ROOT_DIR}" submodule update --init --recursive

echo "[2/5] Applying Java compatibility patch to libxposed service..."
if git -C "${SERVICE_DIR}" apply --check "${PATCH_FILE}" >/dev/null 2>&1; then
    git -C "${SERVICE_DIR}" apply "${PATCH_FILE}"
    echo "Patch applied successfully."
else
    if git -C "${SERVICE_DIR}" apply --reverse --check "${PATCH_FILE}" >/dev/null 2>&1; then
        echo "Patch already applied; skipping."
    else
        echo "Patch cannot be applied cleanly. Please verify repository state."
        exit 1
    fi
fi

echo "[3/5] Publishing libxposed service artifacts to mavenLocal..."
"${SERVICE_DIR}/gradlew" -p "${SERVICE_DIR}" :interface:publishInterfacePublicationToMavenLocal :service:publishServicePublicationToMavenLocal

echo "[4/5] Publishing libxposed api artifacts to mavenLocal..."
"${API_DIR}/gradlew" -p "${API_DIR}" :api:publishApiPublicationToMavenLocal

echo "[5/5] Building Libresposed..."
"${ROOT_DIR}/gradlew" -p "${ROOT_DIR}" build

echo "All steps completed successfully."

