#!/bin/bash

echo "This script will clone the Bitwarden Mobile repository and build Android project."

echo "Removing old files..."
rm -rf bitwarden-repo

#???
sudo apt install openjdk-8-jdk

echo "Cloning Bitwarden Mobile repository..."
git clone --depth 1 https://github.com/bitwarden/mobile bitwarden-repo
cd bitwarden-repo || exit
git fetch --unshallow

nuget restore
dotnet tool restore
dotnet tool run dotnet-format --check
dotnet cake build.cake --target Android --variant prod

echo "Building Android project in Debug..."
msbuild src/Android/Android.csproj /p:Configuration=Debug

echo "Building Android project in Debug again..."
msbuild src/Android/Android.csproj /t:Clean
msbuild src/Android/Android.csproj /p:Configuration=Debug