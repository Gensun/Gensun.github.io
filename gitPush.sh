#!/bin/bash

echo "starting commit $* to github"
if [[ "$*" ]]; then
	#statements
	git add .
git commit -m "$*"
git push
echo "finish push 🍺🍺🍺🍺🍺🍺 ✅"
fi
echo "Empty Commit Message, must write ❌❌❌❌"