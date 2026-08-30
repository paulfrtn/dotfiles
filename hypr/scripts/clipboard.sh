#!/bin/bash

cliphist list |\
wofi --dmenu --style ~/.config/wofi/cliphist.css |\
cliphist decode |\
wl-copy	
