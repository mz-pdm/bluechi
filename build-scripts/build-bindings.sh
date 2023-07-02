#!/bin/bash -xe
# SPDX-License-Identifier: GPL-2.0-or-later

# Important note: 
# Run from root directory

# Parse package version from the project
meson setup builddir
VERSION="$(meson introspect --projectinfo builddir | jq -r '.version')"

function python() {
    # Package python bindings
    PYTHON_BINDINGS_DIR="src/bindings/python/"
    ## Set version and release
    sed \
        -e "s|@VERSION@|${VERSION}|g" \
        < $PYTHON_BINDINGS_DIR"setup.py.in" \
        > $PYTHON_BINDINGS_DIR"setup.py"
        
    python3 $PYTHON_BINDINGS_DIR"setup.py" bdist_wheel --dist-dir=dist/
}

echo "Building bindings $1"
echo ""
$1