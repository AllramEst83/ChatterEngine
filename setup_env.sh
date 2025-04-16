#!/bin/bash

# To run: bash setup_env.sh

ENV_NAME="chatter-env-py310"
PYTHON_BIN=$(which python3.10)

echo "🔧 Creating virtualenv: $ENV_NAME using $PYTHON_BIN"
$PYTHON_BIN -m venv $ENV_NAME

echo "✅ Activating virtualenv..."
source $ENV_NAME/bin/activate

echo "📦 Upgrading pip..."
pip install --upgrade pip

echo "📦 Installing compatible setuptools version (<74.0.0)..."
pip install "setuptools<74.0.0" wheel

echo "🔥 Installing PyTorch (CUDA 12.6)..."
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126

echo "📄 Installing ESPnet with additional packages..."
pip install "espnet[all]"

echo "📄 Installing base requirements..."
pip install typing-extensions==4.12.2
pip install -r requirements.txt

echo ""
echo "✅ Environment '$ENV_NAME' is ready!"
echo "👉 To activate later: source $ENV_NAME/bin/activate"
