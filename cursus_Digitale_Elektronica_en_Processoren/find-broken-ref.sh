#!/bin/bash
grep '^LaTeX Warning: Reference' < logger.dat | sed "s/[\'\`]/\"/g" | grep '"[^"]*"*' -o | sort | uniq | less
