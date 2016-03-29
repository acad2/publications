#!/bin/bash
git checkout master; git merge --no-ff dep -m "merge from dep"; git checkout dep
