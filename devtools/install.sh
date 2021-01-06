#!/bin/bash

TEMP_DIR=~/tmp/setup
if [ -d $TEMP_DIR ]
then
    rm -rf $TEMP_DIR
fi

mkdir -p $TEMP_DIR

# Install jq
if ! jq --version &> /dev/null
then
    echo "Installing jq"
    sudo apt install jq -y
else
    echo "jq is already installed"
fi

# Install bat
if ! batcat --version &> /dev/null
then
    echo "Installing bat"
    sudo apt install bat -y
    echo "alias cat='batcat'" >> ~/.bashrc
else
    echo "bat is already installed"
fi

# Install GCC
if ! gcc -v &> /dev/null
then
    echo "Installing GCC"
    sudo apt install gcc -y
else
    echo "GCC is already installed"
fi

# Install Go
if ! go version &> /dev/null
then
    echo "Installing Go"
    GO_VERSION=$(curl https://golang.org/VERSION?m=text)
    echo "Downloading version $GO_VERSION of Go"
    wget "https://dl.google.com/go/$GO_VERSION.linux-amd64.tar.gz" -O $TEMP_DIR/go.tar.gz
    sudo mkdir -p /usr/local/go
    sudo tar -xzf $TEMP_DIR/go.tar.gz -C /usr/local
    echo 'PATH="/usr/local/go/bin:$PATH"' >> ~/.bashrc
else
    echo "Go is already installed"
fi

# Install Zig
if ! zig version &> /dev/null
then
    echo "Installing Zig"
    curl https://ziglang.org/download/index.json > $TEMP_DIR/zig.json
    ZIG_VERSION=$(jq "keys_unsorted|.[1]" $TEMP_DIR/zig.json)
    ZIG_URL=$(jq ".$ZIG_VERSION|.\"x86_64-linux\"|.\"tarball\"" $TEMP_DIR/zig.json | tr -d \")
    echo "Downloading version $ZIG_VERSION of Zig"
    wget $ZIG_URL -O $TEMP_DIR/zig.tar.xz
    sudo tar -xvf $TEMP_DIR/zig.tar.xz -C $TEMP_DIR
    rm $TEMP_DIR/zig.json $TEMP_DIR/zig.tar.xz
    ZIG_DIR=$(ls $TEMP_DIR | grep zig)
    sudo mkdir -p /usr/local/zig
    sudo mv $TEMP_DIR/$ZIG_DIR/* /usr/local/zig
    echo 'PATH="/usr/local/zig:$PATH"' >> ~/.bashrc
else
    echo "Zig is already installed"
fi

# Install docker
if ! docker -v &> /dev/null
then
    echo "Installing docker"
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get -y install docker-ce docker-ce-cli containerd.io
else
    echo "Docker is already installed"
fi

# Clean up
rm -rf $TEMP_DIR

source ~/.bashrc
