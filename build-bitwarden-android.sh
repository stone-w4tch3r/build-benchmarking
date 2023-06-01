#!/bin/bash

echo "This script will clone the Bitwarden Mobile repository and build Android project."

echo "Removing old files..."
rm -rf bitwarden-repo

echo "Cloning Bitwarden Mobile repository..."
git clone --depth 1 https://github.com/bitwarden/mobile bitwarden-repo
git fetch --unshallow

cd bitwarden-repo || exit

echo "Restoring NuGet packages..."
nuget restore

echo "Restoring dotnet tool..."
dotnet tool restore

echo "Checking with dotnet-format..."
dotnet tool run dotnet-format --check

echo "Preparing build with cake..."
dotnet cake build.cake --target Android --variant prod

echo "Building Android project in Debug..."
msbuild src/android/Android.csproj /p:Configuration=Debug

echo "Cleaning Android project..."
msbuild src/android/Android.csproj /t:Clean

echo "Building Android project in Debug again..."
msbuild src/android/Android.csproj /p:Configuration=Debug