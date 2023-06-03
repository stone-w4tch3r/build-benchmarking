#!/bin/bash

echo "Installing xamarin.android build dependencies..."
sudo apt-get -y install autoconf autotools-dev automake cmake build-essential curl gcc g++ g++-mingw-w64 gcc-mingw-w64 git libncurses5-dev libtool libz-mingw-w64-dev libzip-dev linux-libc-dev make ninja-build p7zip-full sqlite3 vim-common zlib1g-dev libtool-bin  ccache cli-common-dev devscripts

cd ~ || return 1
git clone https://github.com/xamarin/xamarin-android.git
cd xamarin-android || return 1
git checkout 5ca9ebd #latest stable commit as of 2023-06-02

echo "Building xamarin.android..."
make prepare
make

echo "Installing xamarin.android..."
sudo make install prefix=/usr