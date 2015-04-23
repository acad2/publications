#!/bin/bash
cut -d '/' -f 1 | tr '\n' ' ' | sed -r 's/\w+/(CC\0)/g' | sed -r 's/\)\s*\(/) (/g' | sed -r 's/^\s*(.*?)\s*$/\\groupbox{\0}{}/g'
