#!/bin/bash

# ---------- CONFIG ----------
PROJECTS_DIR=~/projects
CHATTERENGINE_DIR="$PROJECTS_DIR/chatterengine"
ENV_PATH="$CHATTERENGINE_DIR/.chatter-env-py310"
PYTHON_BIN=$(which python3.10)
KALDI_DIR="$PROJECTS_DIR/kaldi"
ESP_DIR="$PROJECTS_DIR/espnet"

echo "✅ Activating virtualenv..."
source "$ENV_PATH/bin/activate"

# ---------- (RE)BUILD KALDI ----------
if [ ! -f "$KALDI_DIR/src/kaldi.mk" ]; then
    echo "🔨 Building Kaldi from source..."
    cd $KALDI_DIR/tools
    extras/check_dependencies.sh
    make -j$(nproc)

    cd ../src
    ./configure --shared
    make -j$(nproc)
else
    echo "✅ Kaldi already compiled"
fi

# ---------- CLEAN UP PATH ISSUES FOR MAKE ----------
# Avoid issues like "/bin/sh: export: Files/NVIDIA: bad variable name"
unset CUDA_HOME
export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v "Files/NVIDIA" | paste -sd ':' -)

# ---------- INSTALL ESPnet TOOLS ----------
cd $ESP_DIR/tools

# Safe re-run
make

# Install recommended modules
echo "📦 Installing optional ESPnet modules..."

installers/install_warp-transducer.sh
installers/install_chainer_ctc.sh
installers/install_pyopenjtalk.sh
installers/install_tdmelodic_pyopenjtalk.sh
installers/install_kenlm.sh
installers/install_py3mmseg.sh
installers/install_fairseq.sh
installers/install_phonemizer.sh
installers/install_gtn.sh
installers/install_s3prl.sh
installers/install_transformers.sh
installers/install_speechbrain.sh
installers/install_k2.sh
installers/install_longformer.sh
installers/install_cauchy_mult.sh       # pykeops
installers/install_whisper.sh
installers/install_rawnet.sh
installers/install_reazonspeech.sh
installers/install_discrete_speech_metrics.sh
installers/install_lightning.sh
installers/install_muskits.sh

# Required decoders
installers/install_sctk.sh              # sclite
installers/install_sph2pipe.sh
installers/install_pesq.sh
installers/install_beamformit.sh

# ---------- FINAL CHECK ----------
echo ""
echo "🧪 Running ESPnet environment check..."
bash -c ". ./activate_python.sh; . ./extra_path.sh; python3 check_install.py"
