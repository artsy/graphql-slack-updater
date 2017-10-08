#!/usr/local/bin/fish

git clone https://github.com/artsy/metaphysics.git temp/metaphysics
cd temp/metaphysics
git pull origin master
# nvm use 8.4
# yarn install
yarn dump-schema ../../schema/new

# We don't need the JSON file
rm ../../schema/new/schema.json 
# We want this though
mv ../../schema/new/schema.graphql ../../schema/new/metaphysics.graphql
