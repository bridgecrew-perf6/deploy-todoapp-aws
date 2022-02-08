#!/bin/bash
rm -fr src/react-simple-todo-app;
mkdir -p src
cd src
git clone https://github.com/coccus1991/react-simple-todo-app.git
cd react-simple-todo-app
npm i
npm run build
cd ../

git clone https://github.com/coccus1991/open-id-client-serverless.git

git clone https://github.com/coccus1991/todo-app-serverless.git