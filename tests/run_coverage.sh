#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
APP_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
WEB2PY_ROOT="$(cd -- "${APP_ROOT}/../.." && pwd)"

PYTHON_BIN="${PYTHON:-python3}"
COVERAGE_RC="${APP_ROOT}/.coveragerc"
HTML_DIR="${APP_ROOT}/coverage_html"
XML_FILE="${APP_ROOT}/coverage.xml"

if ! "${PYTHON_BIN}" -m coverage --version >/dev/null 2>&1; then
    cat <<EOF >&2
coverage is not installed for ${PYTHON_BIN}

Install it with:
  ${PYTHON_BIN} -m pip install coverage
EOF
    exit 1
fi

cd "${WEB2PY_ROOT}"

export COVERAGE_PROCESS_START="applications/eden/.coveragerc"

"${PYTHON_BIN}" -m coverage erase
"${PYTHON_BIN}" -m coverage run \
    --rcfile="${COVERAGE_RC}" \
    --parallel-mode \
    web2py.py -S eden -M -R applications/eden/modules/unit_tests/suite.py
"${PYTHON_BIN}" -m coverage combine --rcfile="${COVERAGE_RC}"
"${PYTHON_BIN}" -m coverage report --rcfile="${COVERAGE_RC}" -m
"${PYTHON_BIN}" -m coverage html --rcfile="${COVERAGE_RC}" -d "${HTML_DIR}"
"${PYTHON_BIN}" -m coverage xml --rcfile="${COVERAGE_RC}" -o "${XML_FILE}"

cat <<EOF

Coverage reports generated:
  ${HTML_DIR}/index.html
  ${XML_FILE}
EOF
