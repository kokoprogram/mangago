#!/bin/bash

cd $(dirname $(realpath $0))
rm -r -f node_modules
npm install
git pull
node --max-old-space-size=4096 . undefined undefined 2500

if [ $(grep -c '"valid":\s[1-9]' report.json) == 1 ] && [ $(grep -c '"invalid":\s[1-9]' report.json) == 0 ]
then
    git add .
    git commit -m 'autoupdate'
    git push
else
    git clean -f -d
    git checkout -f
fi
