#!/bin/bash

echo ">>>this script builds eShopOnContainers"

echo ">>>fetching eShopOnContainers repository..."
git clone --depth 1 https://github.com/dotnet-architecture/eShopOnContainers eShopOnContainers-repo
cd eShopOnContainers-repo || return 1
git fetch --unshallow

echo ">>>building eShopOnContainers..."
cd src || return 1
docker-compose build

