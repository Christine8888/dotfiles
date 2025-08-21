#!/bin/bash

# 1) Setup linux dependencies
su -c 'apt-get update && apt-get install -y sudo'
sudo apt-get install -y less nano htop ncdu nvtop lsof rsync btop jq

# 2) Setup virtual environment
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
uv python install 3.11
uv venv
source .venv/bin/activate
uv pip install ipykernel simple-gpu-scheduler # very useful on runpod with multi-GPUs https://pypi.org/project/simple-gpu-scheduler/
python -m ipykernel install --user --name=venv # so it shows up in jupyter notebooks within vscode

# 3) Setup dotfiles and ZSH
mkdir git && cd git
git clone https://github.com/jplhughes/dotfiles.git
cd dotfiles
./install.sh --zsh --tmux
chsh -s /usr/bin/zsh
./deploy.sh
cd ..

# 4) Setup github
echo ./scripts/setup_github.sh "christineye88@outlook.com" "Christine Ye"

# 5) Install various things Christine needs
uv run python -m ipykernel install --user --name "venv"
uv pip install dotenv trl transformers torch "huggingface_hub[cli]" wandb dotenv deepspeed
uv pip install vllm --torch-backend=auto
export HF_HOME="/workspace/.cache/huggingface"
cd /workspace/rl-character/safety-tooling
uv pip install -e .
uv pip install git+https://github.com/UKGovernmentBEIS/inspect_evals
uv pip install git+https://github.com/josejg/instruction_following_eval.git
uv pip install --upgrade openai anthropic
uv pip install inspect-ai
