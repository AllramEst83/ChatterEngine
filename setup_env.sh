#!/bin/bash

ENV_NAME="chatter-env-py310"
PYTHON_BIN=$(which python3.10)

echo "🔧 Creating virtualenv: $ENV_NAME using $PYTHON_BIN"
$PYTHON_BIN -m venv $ENV_NAME

echo "✅ Activating virtualenv..."
source $ENV_NAME/bin/activate

echo "📦 Upgrading pip and setuptools..."
pip install --upgrade pip setuptools wheel

echo "🔥 Installing PyTorch (CUDA 12.6)..."
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126

echo "📄 Installing base requirements..."
pip install typing-extensions==4.12.2
pip install -r requirements.txt

echo ""
echo "✅ Environment '$ENV_NAME' is ready!"
echo "👉 To activate later: source $ENV_NAME/bin/activate"
