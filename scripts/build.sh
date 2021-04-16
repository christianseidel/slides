
rm -rf dist/img
cp -R slides/img dist
cd dist
tree -H '.' -L 1 --noreport --charset utf-8 > index.html
cd ..
git status