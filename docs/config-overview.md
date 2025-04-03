# 📞 ChatterEngine Config System

Each ChatterEngine module is configured using a dedicated YAML file inside the `/config` directory.

This setup allows hot-swapping of models and quick reconfiguration without modifying source code.

---

## 🔊 STT Configuration

**File:** `config/stt_config.yaml`

```yaml
language: sv
model_path: "stt/models/swedish_model.pt"
sample_rate: 16000
decoder: beam # Options: 'beam', 'greedy'
use_gpu: true
```

---

## 🌍 NMT Configuration

**File:** `config/nmt_config.yaml`

```yaml
source_lang: sv
target_lang: en
model_path: "nmt/models/sv_en_transformer.pt"
beam_size: 5
max_tokens: 512
use_gpu: true
```

---

## 🔦 TTS Configuration

**File:** `config/tts_config.yaml`

```yaml
language: en
model_name: "tts_models/en/ljspeech/tacotron2-DDC"
output_dir: "tts/output/"
use_gpu: true
```

---

## 🧠 Loading Configs in Python

All modules follow a consistent config loading pattern:

```python
import yaml

with open("config/stt_config.yaml", "r") as f:
    config = yaml.safe_load(f)
```

Use CLI flags like `--config` to support model swaps during runtime.
