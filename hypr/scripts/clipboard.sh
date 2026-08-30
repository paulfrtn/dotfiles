#!/bin/bash

cliphist list |\
wofi --dmenu --style ~/.config/wofi/variants/cliphist.css |\
cliphist decode |\
wl-copy	
