#!/usr/local/bin/fish

git clone https://github.com/artsy/metaphysics.git temp/metaphysics
cd temp/metaphysics

nvm use 8.4

# Install deps and generate the schema
yarn install
yarn dump-schema ../../schema/new

# We don't need the JSON file
rm ../../schema/new/schema.json 
# We want this though
mv ../../schema/new/schema.graphql ../../schema/new/metaphysics.graphql
