#!/usr/bin/env bash

# This script creates the index of all of the examples and problem
# solutions at the end of the README.md file.

find -s $(dirname $0) -name '*.asm' -exec head -1 {} \; -print | \
    sed 's/\(; ..*\)/[\1](/g;N;s/\n//g;s/$/?plaintext=1)/g;s/^\[; /* [/g'
