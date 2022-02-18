#!/bin/bash
rm -fr src/react-simple-todo-app;
rm -fr src/open-id-client-serverless;
rm -fr src/todo-app-serverless;

mkdir -p src
cd src
SRC_PATH=$(pwd)

git clone https://github.com/coccus1991/react-simple-todo-app.git
cd react-simple-todo-app
npm i
npm run build
cat <<EOT > dist/configs/api.json
{
  "baseUrl": "/api/v1"
}
EOT

cd $SRC_PATH

git clone https://github.com/coccus1991/open-id-client-serverless.git
cd open-id-client-serverless/src
npm install --production

cd $SRC_PATH

git clone https://github.com/coccus1991/todo-app-serverless.git
cd todo-app-serverless/src
npm install --production

cd $SRC_PATH