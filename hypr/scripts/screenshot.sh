#!/bin/bash

grim -g "$(slurp)" - | satty -f - \
    --resize 1200x800 \
    --copy-command wl-copy \
    --floating-hack \
    -o "~/Pictures/Screenshots/%y-%m-%d_%H-%M-%S.png" \
    --actions-on-escape save-to-clipboard,save-to-file,exit \
    --disable-notifications \
