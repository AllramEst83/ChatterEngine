# 👨‍💻 Developer Notes & Tips

This document collects practical advice, gotchas, and ideas for evolving ChatterEngine's codebase.

---

## 💥 Common Pitfalls

- STT models typically expect **16kHz mono audio**. Resample before inference.
- TTS models require **clean, normalized text** (lowercase, no symbols).
- Maintain consistent **tokenization** across STT and NMT.
- Check that GPU config flags are aligned across YAML files.

---

## 🧪 Testing With Dummy Inputs

To debug the flow without training anything:

- Use a test clip like `samples/test_sv.wav`
- Print out transcription and translation steps
- Comment out TTS to test just STT → NMT

---

## 🔄 Debugging Tips

- Print out loaded `config` objects to confirm paths/values
- Use `torchaudio.save("debug.wav", waveform, sample_rate)` to inspect intermediate results
- Implement a `--dry-run` flag to skip synthesis and focus on text

---

## 🛠️ CLI Enhancements (To Add)

These are useful additions to `run_pipeline.py`:

- `--lang sv` or `--lang en`: switch between language modes
- `--output-dir path/`: override output audio path
- `--dry-run`: STT + NMT only, no synthesis
- `--log`: save transcription + translation to file for evaluation

---

## 🌐 Internationalization Ideas

- Add a `config/lang_map.yaml` to map STT/NMT/TTS configs by language code
- Use ISO codes for dynamic routing (e.g., `sv`, `en`, `es`)
- Load modules dynamically based on user input or speech detection

---

## 🎓 Future Explorations

- Add streaming inference (real-time mode)
- Move to ONNX for deployment
- Add voice activity detection (VAD) or silence trimming
- Create `serve/` API layer with FastAPI or gRPC

Stay modular, stay multilingual ✨
