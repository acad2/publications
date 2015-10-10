#!/bin/bash
grep --color '^LaTeX Warning: Reference' logger.dat | less -r
