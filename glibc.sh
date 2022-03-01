#!/bin/bash

GLIBC_VER=2.32
WORKING_DIR=${PWD}/glibc

# Beginning of the compilation
echo -e "[+] Starting to build glibc-${GLIBC_VER} from source"

# Creating Working Directory
echo -e "[+] Preparing working directory..."
mkdir $WORKING_DIR/ && cd WORKING_DIR/
mkdir build 
mkdir glibc-${GLIBC_VER}-install

# Prepare source code
echo -e "[+] Downloading and preparing source code..."
wget http://ftp.gnu.org/gnu/libc/glibc-${GLIBC_VER}.tar.gz
tar -xvzf glibc-${GLIBC_VER}.tar.gz

# Start compilation
echo -e "[+] Building glibc-${GLIBC_VER} from source..."
cd build
${PWD}/glibc/glibc-${GLIBC_VER}/configure --prefix=${PWD}/glibc/glibc-${GLIBC_VER}-install
make

# Start compilation
echo -e "[+] Intalling glibc-${GLIBC_VER}..."
make install

# End
echo -e "Done!"
