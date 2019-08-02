#!/bin/bash

if [[ "$*" ]]; then
	#statements
	echo "starting commit $* to github"
	git add .
	git commit -m "$*"
	git push
	echo "finish push 🍺🍺🍺🍺🍺🍺 ✅"
else
	echo "Empty Commit Message, must write ❌❌❌❌"
fi
