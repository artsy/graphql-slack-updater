git clone https://github.com/artsy/metaphysics.git temp/metaphysics
cd temp/metaphysics
yarn install
yarn babel-node scripts/dump-schema.js schema/metaphyics._json
