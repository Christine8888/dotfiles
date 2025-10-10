#!/bin/bash

SCR=/scr-ssd/cye
mkdir -p $SCR
cd $SCR

export UV_CACHE_DIR="$SCR/.cache/uv"
uv python install 3.11
uv venv --python 3.11
source .venv/bin/activate

uv pip install dotenv trl transformers torch "huggingface_hub[cli]" wandb dotenv deepspeed
uv pip install vllm --torch-backend=auto
export HF_HOME="$SPHINX/.cache/huggingface"
cd $SPHINX/emergent-doordash
uv pip install -e .
uv pip install inspect-ai
uv pip install --upgrade openai anthropic transformers
uv pip install numpy==2.2
