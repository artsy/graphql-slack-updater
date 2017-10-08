#!/usr/local/bin/fish

git clone https://github.com/artsy/metaphysics.git temp/metaphysics
cd temp/metaphysics
git pull origin master
# nvm use 8.4
# yarn install
yarn dump-schema ../../schema/new
mv ../../schema/new/schema.json ../../schema/new/metaphysics.json
mv ../../schema/new/schema.graphql ../../schema/new/metaphysics.graphql
