#!/bin/bash

basnam=$(basename "$1" ".uxf")
umlet -action=convert -format=pdf -filename="UML/$basnam.uxf"
mv "UML/$basnam.pdf" .
