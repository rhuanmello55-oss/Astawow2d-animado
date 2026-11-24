#!/usr/bin/env bash
# install.sh [claude|codex|gemini|all] — instala a skill onde cada agente procura. Rode de dentro da pasta da skill.
set -e
D="$(cd "$(dirname "$0")" && pwd)"; T="${1:-all}"
claude() { mkdir -p ~/.claude/skills ~/.claude/agents ~/.claude/commands; rm -rf ~/.claude/skills/astawow-2d-animator; cp -r "$D" ~/.claude/skills/astawow-2d-animator
  cp "$D"/agents/animation-qa.md "$D"/agents/detalhista.md "$D"/agents/audio-qa.md ~/.claude/agents/; cp "$D"/commands/animar.md ~/.claude/commands/; echo "Claude Code: skill + agentes (detalhista, audio-qa, animation-qa) + /animar instalados."; }
codex()  { mkdir -p ~/.codex/skills; rm -rf ~/.codex/skills/astawow-2d-animator; cp -r "$D" ~/.codex/skills/astawow-2d-animator; echo "Codex: copiado para ~/.codex/skills. Em projetos, deixe AGENTS.md na raiz (já vem na pasta)."; }
gemini() { mkdir -p ~/.gemini/skills; rm -rf ~/.gemini/skills/astawow-2d-animator; cp -r "$D" ~/.gemini/skills/astawow-2d-animator; echo "Gemini CLI/Antigravity: copiado para ~/.gemini/skills (GEMINI.md na raiz da pasta)."; }
case "$T" in claude) claude;; codex) codex;; gemini) gemini;; all) claude; codex; gemini;; *) echo "uso: install.sh [claude|codex|gemini|all]"; exit 1;; esac
echo; echo "Dependências de áudio (opcional, recomendado): pip install -r requirements.txt && pip install --no-deps tinysoundfont &&  python3 audio/models.py   (instrumentos reais da música, ~35 MB uma vez)"
echo "Requisitos: node 18+, ffmpeg, python3 (numpy scipy), playwright+chromium — veja SKILL.md."
