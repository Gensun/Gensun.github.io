#!/bin/bash

echo "starting $*"
git add .
git commit -m "$*"
git push
echo "end"