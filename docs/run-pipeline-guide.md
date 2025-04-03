# 🔁 `run_pipeline.py` – Full Speech-to-Speech Flow

This script handles the full end-to-end speech translation pipeline:

```
Audio Input → STT → NMT → TTS → Audio Output
```

---

## ⚡ Usage

```bash
python pipeline/run_pipeline.py --audio path/to/input.wav
```

Make sure you have:

- ✅ All three modules implemented: STT, NMT, TTS
- ✅ YAML configs in `/config`
- ✅ Required model files downloaded

---

## 🧠 Pipeline Logic (Simplified)

```python
stt_model, stt_cfg = load_stt_model()
text_sv = transcribe_audio("input.wav", stt_model)

nmt_model, nmt_cfg = load_nmt_model()
text_en = translate_text(text_sv, nmt_model)

tts_model, tts_cfg = load_tts_model()
synthesize_speech(text_en, tts_model)
```

Each module loads its model and config independently, keeping things modular and reusable.

---

## 📂 Output

- Synthesized audio is saved to: `tts/output/output.wav`
- Console prints show:
  - Transcribed STT output
  - Translated text
  - TTS status and audio path

---

## 🎓 Extend This Pipeline

You can enhance the pipeline with flags or behaviors:

- `--lang sv` or `--lang en` to auto-switch direction
- `--dry-run` to only do STT + NMT
- `--output path.wav` to set output filename

The goal: keep it developer-friendly but production-ready.
