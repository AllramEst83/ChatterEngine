# 🤝 Contributing to ChatterEngine

Thank you for your interest in contributing! ChatterEngine is an open and modular speech-to-speech translation pipeline — contributions are welcome in all forms.

---

## 🧑‍💻 How to Contribute

### 1. Clone the Repo

```bash
git clone https://github.com/yourusername/chatterengine.git
cd chatterengine
```

### 2. Set Up Your Environment

- Use Python 3.9+
- Recommended: [VS Code + WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) for full Linux tool support
- Install requirements for each module: `stt/`, `nmt/`, `tts/`

### 3. Use Git Branches

```bash
git checkout -b feature/your-feature-name
```

---

## 📂 Repo Structure

```
chatterengine/
├── config/          # YAML configs
├── stt/             # Speech-to-text
├── nmt/             # Translation
├── tts/             # Text-to-speech
├── pipeline/        # Full flow script
├── serve/           # FastAPI/gRPC services
├── data/            # Dataset loader scripts
├── samples/         # Sample audio/text
```

---

## ✅ Guidelines

- Follow existing code structure and docstrings
- Keep YAML config consistent and reusable
- Add tests if adding utilities or functions
- Use relative imports within modules

---

## 🛠️ Linting & Formatting

```bash
black .
flake8 .
```

---

## 🧪 Testing

Manual testing only for now. Add sample data in `/samples/` and run:

```bash
python pipeline/run_pipeline.py --audio samples/test_sv.wav
```

---

## 🗣 Suggestions or Bugs?

Open an issue or discussion thread!

---

Thanks for helping build ChatterEngine 🙌
