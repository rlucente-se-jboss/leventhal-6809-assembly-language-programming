#!/usr/bin/env bash

find -s $(dirname $0) -name '*.asm' -exec head -1 {} \; -print | sed 's/\(; ..*\)/[\1](/g;N;s/\n//g;s/$/?plaintext=1)/g;s/^\[; /*[/g'
