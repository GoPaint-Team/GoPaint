@ echo off
echo Deploying your GoPaint based app
git init
git add .
git commit -m "Commited"
git branch -M main
git remote add origin https://github.com/GoPaint-Team/GoPaint.git
git push -u origin main
echo "Success!"