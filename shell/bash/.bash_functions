#!/bin/bash

# Clone a repository and install its dependencies.

function clone() {

    git clone "$1" \
        || return

    cd "$(basename "${1%.*}")" \
        || return

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if there are dependencies to be installed.

    if [ ! -f "package.json" ]; then
        return
    fi

    # Check if the project uses Yarn.

    if [ -f "yarn.lock" ] && command -v "yarn" $> /dev/null; then
        printf "\n"
        yarn install
        return
    fi

    # If not, assume it uses npm.

    if command -v "npm" $> /dev/null; then
        printf "\n"
        npm install
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Create data URI from a file.

function datauri() {

    local mimeType=""

    if [ ! -f "$1" ]; then
        printf "%s is not a file.\n" "$1"
        return
    fi

    mimeType=$(file --brief --mime-type "$1")
    #               └─ do not prepend the filename to the output

    if [[ $mimeType == text/* ]]; then
        mimeType="$mimeType;charset=utf-8"
    fi

    printf "data:%s;base64,%s" \
        "$mimeType" \
        "$(openssl base64 -in "$1" | tr -d "\n")"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Creates a directory and moves into it

function mkcd() {
  mkdir $1 && cd $1
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Get gzipped file size

function gz() {
    local origsize=$(wc -c < "$1")
    local gzipsize=$(gzip -c "$1" | wc -c)
    local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)

    printf "orig: %d bytes\n" "$origsize"
    printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Copies a files' contents to clipboard

function copy_file_contents() {
  cat $1 | pbcopy
  echo "-- '$1' copied to the clipboard! --"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
