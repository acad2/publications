#!/bin/bash

lgf="old-logger.dat"

grep '^LaTeX Warning: Reference' < $lgf | sed "s/[\'\`]/\"/g" | grep '"[^"]*"*' -o | sort | uniq | less
