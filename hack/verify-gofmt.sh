#!/bin/bash

# GoFmt apparently is changing @ head...

set -o errexit
set -o nounset
set -o pipefail

OS_ROOT=$(dirname "${BASH_SOURCE}")/..
source "${OS_ROOT}/hack/lib/init.sh"

os::golang::verify_go_version

cd "${OS_ROOT}"

bad_files=$(find_files | xargs gofmt -s -l)
if [[ -n "${bad_files}" ]]; then
	echo "!!! gofmt needs to be run on the following files: " >&2
	echo "${bad_files}"
	echo "Try running 'gofmt -s -d [path]'" >&2
	echo "Or autocorrect with 'hack/verify-gofmt.sh | xargs -n 1 gofmt -s -w'" >&2
	exit 1
fi
