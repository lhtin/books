set -ex

git add html
git commit -m "build html"
git subtree push --prefix=html origin gh-pages