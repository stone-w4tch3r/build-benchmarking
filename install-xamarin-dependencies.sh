#!/bin/bash

echo "This script will install dependencies for building xamarin android apps on ubuntu 22+ amd64"

sudo apt install ca-certificates gnupg
sudo gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update

echo "Installing mono, nuget and java..."
sudo apt-get -y install mono-complete nuget default-jre
sudo apt-get -y install unzip

echo "Installing android sdk-tools..."
mkdir -p ~/android/sdk
cd ~/android/sdk || return 1
sudo wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
unzip commandlinetools-linux-*.zip
cd cmdline-tools || return 1
mkdir tools
sudo mv -i * tools

echo "export ANDROID_HOME=\$HOME/android/sdk" >> ~/.bashrc
echo "export PATH=\$ANDROID_HOME/cmdline-tools/tools/bin/:\$PATH" >> ~/.bashrc
echo "export PATH=\$ANDROID_HOME/emulator/:\$PATH" >> ~/.bashrc
echo "export PATH=\$ANDROID_HOME/platform-tools/:\$PATH" >> ~/.bashrc
source ~/.bashrc

echo "Installing android sdk packages..."
yes | sdkmanager --licenses
sdkmanager --install "platform-tools" "build-tools;33.0.2" "platforms;android-33" "ndk;25.2.9519653"

echo "Installing dotnet (22.04 required)..."
sudo apt update && sudo apt install dotnet7

echo "Installing xamarin-android linux package..."
cd ~ || return 1
mkdir xamarin-android-install
cd xamarin-android-install || return 1
#latest version as of 2023--06--3
wget https://artprodcus3.artifacts.visualstudio.com/Ad0adf05a-e7d7-4b65-96fe-3f3884d42038/6fd3d886-57a5-4e31-8db7-52a1b47c07a8/_apis/artifact/cGlwZWxpbmVhcnRpZmFjdDovL3hhbWFyaW4vcHJvamVjdElkLzZmZDNkODg2LTU3YTUtNGUzMS04ZGI3LTUyYTFiNDdjMDdhOC9idWlsZElkLzU0OTUzL2FydGlmYWN0TmFtZS9pbnN0YWxsZXJzLXVuc2lnbmVkKy0rTGludXg1/content?format=zip --output-document=xamarin-android-installer.zip
unzip xamarin-android-installer.zip
rm xamarin-android-installer.zip
cd 'installers-unsigned - Linux' || return 1
sudo apt-get install -y ./xamarin.android-oss_*.deb