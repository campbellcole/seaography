#!/bin/bash
set -e

# Bump `seaography-derive` version
cd derive
sed -i 's/^version.*$/version = "'$1'"/' Cargo.toml
git commit -am "seaography-derive $1"
cd ..
sleep 1

# Bump `seaography-discoverer` version
cd discoverer
sed -i 's/^version.*$/version = "'$1'"/' Cargo.toml
git commit -am "seaography-discoverer $1"
cd ..
sleep 1

# Bump `seaography-generator` version
cd generator
sed -i 's/^version.*$/version = "'$1'"/' Cargo.toml
git commit -am "seaography-generator $1"
cd ..
sleep 1

# Bump `seaography-cli` version
cd cli
sed -i 's/^version.*$/version = "'$1'"/' Cargo.toml
sed -i 's/^seaography-discoverer [^,]*,/seaography-discoverer = { version = "\^'$1'",/' Cargo.toml
sed -i 's/^seaography-generator [^,]*,/seaography-generator = { version = "\^'$1'",/' Cargo.toml
git commit -am "seaography-cli $1"
cd ..
sleep 1

# Bump `seaography` version
sed -i 's/^version.*$/version = "'$1'"/' Cargo.toml
sed -i 's/^seaography-derive [^,]*,/seaography-derive = { version = "\^'$1'",/' Cargo.toml
git commit -am "$1"
sleep 1

# Bump examples' dependency version
cd examples
find . -depth -type f -name '*.toml' -exec sed -i 's/^version.*$/version = "'$1'"/' {} \;
find . -depth -type f -name '*.toml' -exec sed -i 's/^version = "\^.*" # seaography version$/version = "\^'$1'" # seaography version/' {} \;
git commit -am "update examples"
