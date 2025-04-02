# Welcome to ChatterEngine

This project is my attempt to learn how to build my own **Speech-to-Speech Translation Engine**, completely open and modular.

### 🎯 Use Case

The goal is to develop a **speech-to-speech translation system** with an optional **text output feature**, supporting Swedish → English.

---

## 🚀 Goals

### 🔊 Speech Recognition (STT)

- [Speech Recognition Phonetics – Jonathan Hui](https://jonathan-hui.medium.com/speech-recognition-phonetics-d761ea1710c0)
- [Build an End-to-End STT Model – Symbl.ai](https://symbl.ai/developers/blog/a-guide-to-building-an-end-to-end-speech-recognition-model/)
- [Analytics Vidhya STT Guide](https://www.analyticsvidhya.com/blog/2019/07/learn-build-first-speech-to-text-model-python/)
- [ESPnet](https://github.com/espnet/espnet) | [Fairseq + Wav2Vec 2.0](https://github.com/facebookresearch/fairseq)

### 🌍 Machine Translation (NMT)

- [Natural Language Processing is Fun!](https://medium.com/@ageitgey/natural-language-processing-is-fun-9a0bff37854e)
- [OPUS Corpus](https://opus.nlpl.eu/)
- [Fairseq](https://github.com/facebookresearch/fairseq) | [OpenNMT-py](https://github.com/OpenNMT/OpenNMT-py)

### 🗣️ Text-to-Speech (TTS)

- Exploring methods like Tacotron2, FastSpeech2, HiFi-GAN
- [ESPnet TTS](https://espnet.github.io/espnet/tts.html)
- [Coqui TTS](https://github.com/coqui-ai/TTS)

---

## 🛠️ Process Overview

**Speech Recognition** → **Machine Translation** → **Text-to-Speech Synthesis**

This project will combine **automatic speech recognition (ASR)**, **neural machine translation**, and **text-to-speech synthesis** to create a seamless translation system.

---

## 📌 Detailed Roadmap

### 🎤 1. Speech-to-Text (STT)

#### 📚 Learn

- Audio features: MFCC, mel spectrograms
- CTC vs attention-based models
- Transformers (Conformer)
- Evaluation: WER

#### 🧪 Build

- Load and preprocess audio with `torchaudio`
- Extract features and train CTC model (LSTM)
- Evaluate with greedy decoding

#### 🚀 Extend

- Use ESPnet or NeMo for larger models
- Add language model (KenLM or transformer-based)
- Train on Swedish Common Voice

#### ⚙️ Deploy

- TorchScript or ONNX export
- Real-time decoder module

---

### 🌍 2. Neural Machine Translation (NMT)

#### 📚 Learn

- Seq2Seq, attention, Transformer models
- Tokenization (BPE) using SentencePiece
- Evaluation: BLEU, chrF

#### 🧪 Build

- Download parallel corpora (Swedish-English)
- Preprocess, tokenize, apply BPE
- Train transformer using Fairseq or OpenNMT

#### 🚀 Extend

- Integrate pretrained embeddings or multilingual transformers
- Tune hyperparameters and layers

#### ⚙️ Deploy

- TorchScript model
- Expose as translation microservice

---

### 🗣️ 3. Text-to-Speech (TTS)

#### 📚 Learn

- Text normalization, G2P
- Tacotron2 / FastSpeech2 (text → mel)
- Vocoder: Griffin-Lim, WaveGlow, HiFi-GAN

#### 🧪 Build

- Train Tacotron2 on LJSpeech
- Generate audio using HiFi-GAN

#### 🚀 Extend

- Fine-tune on custom speaker
- Add prosody control (style tokens)

#### ⚙️ Deploy

- Export model (ONNX)
- Stream audio output as a service

---

## 📦 Datasets

| Type | Dataset                         | Language | Notes                |
| ---- | ------------------------------- | -------- | -------------------- |
| STT  | Common Voice                    | Swedish  | Main STT source      |
| STT  | LibriSpeech                     | English  | Benchmark reference  |
| NMT  | OPUS (Tatoeba, Europarl, JW300) | Sv-En    | Parallel text        |
| TTS  | LJSpeech                        | English  | Clean single-speaker |
| TTS  | VCTK                            | English  | Multi-speaker voices |

---

## 🧰 Key Tools and Frameworks

| Area     | Tool                | Purpose                          |
| -------- | ------------------- | -------------------------------- |
| STT      | ESPnet              | End-to-end pipeline with recipes |
| STT      | Fairseq (Wav2Vec2)  | Self-supervised pretraining      |
| NMT      | Fairseq / OpenNMT   | Transformer training             |
| TTS      | ESPnet-TTS / Coqui  | Tacotron2, FastSpeech2, vocoders |
| Audio    | torchaudio / ffmpeg | Preprocessing and transforms     |
| Export   | ONNX / TorchScript  | Model deployment                 |
| Training | PyTorch / Lightning | Core ML framework                |

---

## 📂 Project Modules (Planned)

chatterengine/
├── stt/ # Speech recognition module
├── nmt/ # Translation module
├── tts/ # Text-to-speech module
├── data/ # Raw + preprocessed data
├── utils/ # Feature extraction, tokenization, logging
├── scripts/ # Training, evaluation, conversion
└── serve/ # Microservices for runtime

---

## 🔄 Integration Plan

```text
Audio (Swedish)
    ↓
[ STT Module ] → Swedish Text
    ↓
[ NMT Module ] → English Text
    ↓
[ TTS Module ] → English Speech
```
