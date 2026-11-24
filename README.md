# 🎬 Asta wow 2D animado

Skill para **Claude Code** (e outros agentes de IA) que cria vídeos de animação 2D completos, do roteiro ao MP4 final, 100% por código.

Cada frame é uma função pura do tempo (`seek(t)`) desenhada em canvas 2D. O Playwright captura os frames e o ffmpeg monta o vídeo com áudio — sem dessincronia, sem flicker e totalmente reproduzível.

## ✨ O que ele faz

- Animações 2D estilo desenho clássico (perseguição gato x rato), bonecos palito, flat vector cartoon, low-poly isométrico, mercadinho, campo e mais
- Legendas animadas palavra por palavra, com destaque de cor
- Boca do personagem sincronizada com a narração
- Motor de áudio próprio: 6 estilos de música, 34 efeitos sonoros, ambiências, vozes de personagem e mixagem automática em -14 LUFS
- Motion blur de cinema, bloom, grade de cor, vinheta e grão
- Formatos: vertical 1080x1920, horizontal 1920x1080 ou quadrado
- QA automático: lint, verificador de enquadramento, contact sheet e agentes revisores (`detalhista`, `audio-qa`, `animation-qa`)

## 📦 Requisitos

- Node.js 18+
- ffmpeg
- Python 3 com `numpy`, `scipy` e `Pillow` (`pip install -r requirements.txt`)
- Playwright com Chromium (`npm i playwright && npx playwright install chromium`)

Confira tudo com: `bash scripts/check.sh`

## 🚀 Como usar

1. Instale a skill: `bash install.sh claude`
2. Peça direto em uma frase, por exemplo: *"Faz um vídeo de 10 s do mercadinho"*
   — ou use o comando `/animar <ideia>`
   — ou preencha o formulário do `PROMPT_MESTRE.md`
3. Receba o MP4 final renderizado

## 📁 Estrutura

| Pasta/Arquivo | Conteúdo |
|---|---|
| `SKILL.md` | Instruções principais da skill |
| `PROMPT_MESTRE.md` | Formulário de pedido completo |
| `templates/` | Estilos prontos (toon, stick, mercado, shop, tutorial) |
| `audio/` | Motor de áudio (música, SFX, voz, mixagem) |
| `scripts/` | Render, lint, QA e preparação de áudio |
| `agents/` | Agentes revisores de qualidade |
| `references/` | Guias de escala, composição, estilos, API e mais |
| `exemplo/` | Cena de exemplo com MP4 renderizado |

## 📝 Observações

- Todos os personagens são originais; a skill não copia personagens ou marcas de terceiros.
- Veja o `CHANGELOG.md` para o histórico de versões.
