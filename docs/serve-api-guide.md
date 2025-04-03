# 🌐 ChatterEngine Serve Layer – API Guide

This guide covers the `/serve/` directory, which provides a future interface for running ChatterEngine as a real-time service using **FastAPI** or **gRPC**.

---

## 📂 Directory Overview

```
serve/
├── api/              # FastAPI endpoints per module
│   ├── stt_service.py
│   ├── nmt_service.py
│   └── tts_service.py
├── pipeline/
│   └── bidirectional_handler.py
```

---

## 🚀 Goal

- Run ChatterEngine via REST or streaming API
- Support bidirectional flow: `sv → en` and `en → sv`
- Switch models based on query or route param

---

## 🧠 FastAPI Service Example: STT

```python
from fastapi import FastAPI, UploadFile
from stt.stt_module import load_stt_model, transcribe_audio

app = FastAPI()
stt_model, stt_cfg = load_stt_model("config/stt_config.yaml")

@app.post("/stt")
async def stt(file: UploadFile):
    audio_path = f"temp/{file.filename}"
    with open(audio_path, "wb") as f:
        f.write(await file.read())
    text = transcribe_audio(audio_path, stt_model, stt_cfg)
    return {"transcript": text}
```

---

## 📦 Run the API

```bash
uvicorn serve.api.stt_service:app --reload --port 8000
```

You can run individual services or create a combined pipeline endpoint (see `bidirectional_handler.py`).

---

## 🔄 Future Features

- Streaming audio input with WebSockets or gRPC
- Async queuing system (e.g. Celery)
- Model auto-selection from query (e.g. `lang=sv`)
- Live subtitle/translation stream

---

Build the API like the pipeline: modular, fast, language-flexible.
