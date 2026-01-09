#!/bin/bash
# Auto-deploy wiki to Cloudflare Pages

set -e

cd "$(dirname "$0")"

# Export org-roam notes to markdown
cd ~/sync/org-roam
emacs --batch --load ~/.emacs.d/init.el wiki.org --eval '(org-hugo-export-wim-to-md :all-subtrees)' 2>&1

# Commit and push changes
cd ~/sync/wiki
git add content/
git diff-index --quiet HEAD || git commit -m "Update wiki content auto-deployed from org-roam"
git push origin master

