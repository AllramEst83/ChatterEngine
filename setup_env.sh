#!/bin/bash

# https://espnet.github.io/espnet/notebook/ESPnet2/Course/CMU_SpeechRecognition_Fall2021/general_tutorial.html

# ---------- CONFIG ----------
PROJECTS_DIR=~/projects
CHATTERENGINE_DIR="$PROJECTS_DIR/chatterengine"
ENV_PATH="$CHATTERENGINE_DIR/.chatter-env-py310"
PYTHON_BIN=$(which python3.10)
KALDI_DIR="$PROJECTS_DIR/kaldi"
ESP_DIR="$PROJECTS_DIR/espnet"

sudo clear

echo "🐍 Using Python at: $PYTHON_BIN"

# ---------- SYSTEM DEPS ----------
echo "🔧 Installing system dependencies (SoX, FLAC, build tools)..."
sudo apt-get update
sudo apt-get install -y sox flac build-essential libboost-all-dev unzip wget automake autoconf libtool subversion python3-dev

# ---------- CREATE PROJECTS DIR ----------
mkdir -p $PROJECTS_DIR
cd $PROJECTS_DIR

# ---------- CLONE ESPnet ----------
if [ ! -d "$ESP_DIR" ]; then
    echo "⬇️ Cloning ESPnet..."
    git clone https://github.com/espnet/espnet.git
else
    echo "✅ ESPnet already exists. Skipping clone."
fi

# ---------- CLONE KALDI ----------
if [ ! -d "$KALDI_DIR" ]; then
    echo "⬇️ Cloning Kaldi..."
    git clone https://github.com/kaldi-asr/kaldi.git
else
    echo "✅ Kaldi already exists. Skipping clone."
fi

# ---------- BUILD KALDI ----------
if [ ! -f "$KALDI_DIR/src/kaldi.mk" ]; then
    echo "🔨 Building Kaldi..."
    cd $KALDI_DIR/tools
    extras/check_dependencies.sh
    make -j$(nproc)

    cd ../src
    ./configure
    make -j$(nproc)
else
    echo "✅ Kaldi already built. Skipping compilation."
fi

# ---------- SYMLINK kaldi → espnet/tools ----------
cd $ESP_DIR/tools
if [ ! -L "kaldi" ]; then
    echo "🔗 Creating symlink to Kaldi in espnet/tools"
    ln -s ../../kaldi kaldi
else
    echo "✅ Kaldi symlink already exists in espnet/tools"
fi

# ---------- PYTHON VIRTUAL ENV ----------
if [ ! -d "$ENV_PATH" ]; then
    echo "🐍 Creating virtual environment at $ENV_PATH using $PYTHON_BIN"
    $PYTHON_BIN -m venv "$ENV_PATH"
else
    echo "✅ Virtual environment already exists at $ENV_PATH"
fi

echo "✅ Activating virtualenv..."
source "$ENV_PATH/bin/activate"

# ---------- PYTHON DEPS ----------
echo "📦 Upgrading pip..."
pip install --upgrade pip

echo "📦 Installing setuptools & modern CMake..."
pip install "setuptools<74.0.0" wheel

# ---------- INSTALL MODERN CMAKE (≥3.18, tested 3.24.4) ----------
CMAKE_VERSION=3.24.4
CMAKE_INSTALLER=cmake-${CMAKE_VERSION}-linux-x86_64.sh
CMAKE_BIN=/usr/local/bin/cmake

# Check installed version (if cmake exists) and compare
if ! command -v cmake >/dev/null || ! cmake --version | grep -q "$CMAKE_VERSION"; then
    echo "⬇️ Installing CMake $CMAKE_VERSION system-wide..."
    cd /tmp
    wget -q https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_INSTALLER}
    chmod +x $CMAKE_INSTALLER
    sudo ./$CMAKE_INSTALLER --prefix=/usr/local --skip-license
    rm $CMAKE_INSTALLER
else
    echo "✅ Compatible CMake $CMAKE_VERSION already installed"
fi

# Confirm final version
cmake --version

echo "🔥 Installing PyTorch (CUDA 12.6)..."
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126

echo "📄 Installing ESPnet with all extras..."
pip install "espnet[all]"

echo "📄 Installing base requirements..."
pip install typing-extensions==4.12.2
pip install -r "$ESP_DIR/requirements.txt"

echo ""
echo "✅ All set!"
echo "📂 ESPnet directory: $ESP_DIR"
echo "📂 Kaldi directory: $KALDI_DIR"
echo "🧪 Python venv: $ENV_PATH"
echo "👉 To activate later: source $ENV_PATH/bin/activate"
