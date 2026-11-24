---
name: astawow-2d-animator
description: Cria vídeos de animação 2D (desenho clássico de perseguição gato x rato, bonecos palito, flat vector cartoon, low-poly isométrico, cenário com grama/céu, personagem com boca sincronizada e legendas palavra-por-palavra) 100% por código e exporta MP4 (Shorts 9:16, YouTube 16:9). Use quando o usuário pedir animação 2D, desenho animado, vídeo explicativo animado, cena com personagem, "simulação", mercadinho/pista/campo animados, legenda animada ou short animado. Não depende de nenhum outro pack.
---

# Astawow 2D Animator

Motor próprio: cada frame é uma **função pura do tempo** (`seek(t)`) desenhada em canvas 2D; o Playwright tira print de cada frame e o ffmpeg monta o MP4 (com áudio). Resultado: sem erro de sincronia, sem flicker, reproduzível.

## Requisitos (verifique antes de começar)
`node` (>=18), `ffmpeg`, `python3` + `numpy`, e `playwright` com Chromium (`npm i playwright && npx playwright install chromium`; se já existir, não reinstale). Rode `bash scripts/check.sh` para conferir tudo.

## MODO PEDIDO (prompt mestre embutido — é só pedir)
O usuário pode pedir de qualquer jeito ("faz um vídeo de 10 s do mercadinho") ou colar o formulário de `PROMPT_MESTRE.md`. Extraia estes campos; **o que faltar, decida sozinho e avise em 1 linha** (pergunte UMA vez só se faltar HISTÓRIA ou ESTILO):
`HISTÓRIA` (começo, meio, virada) • `DURAÇÃO` (padrão 10 s) • `FORMATO` (vertical 1080x1920 padrão p/ Shorts; horizontal 1920x1080; quadrado) • `ESTILO` = flat | iso-loja | padaria | mercado | campo | palito | toon • `PERSONAGENS` • `CENÁRIO` • `NARRAÇÃO` (voz.mp3 + roteiro.txt, ou só legenda) • `LEGENDAS` (palavra por palavra, destaque #ff8a3d) • `FINAL` (CTA/iris-out) • `MARCA D'ÁGUA` (só se enviar o PNG).
Atalhos: `bash scripts/new_project.sh <estilo> meu_video` cria o projeto já com o estilo certo; no Claude Code também existe o comando `/animar <ideia>` (arquivo `commands/animar.md`).

## Fluxo obrigatório (siga na ordem)
1. **Entenda o pedido**: formato (9:16 1080x1920 ou 16:9 1920x1080), duração, estilo (ver `references/estilos.md`), se há áudio de narração. Se faltar algo importante, pergunte UMA vez; senão decida e avise.
2. **Crie o projeto**: `bash scripts/new_project.sh <estilo> meu_video` (copia a demo do estilo: index.html, libs e cena.js prontos para editar). Sem script: copie `templates/` e crie `cena.js` (modelo: `exemplo/cena.js`).
3. **Áudio** (se houver): `python3 scripts/prep_audio.py voz.mp3 --text roteiro.txt --fps 30 --out meu_video/` → gera `words.js` (palavras com tempo + envelope da boca). A legenda deve ser IGUAL ao que é falado.
4. **Shotlist**: escreva em comentário no topo do `cena.js` (cena, início-fim em s, o que acontece). Cada cena 2–4 s; troque com corte seco ou flash curto.
5. **Escreva `cena.js`**: defina `const CONFIG={w,h,fps,dur}` e `function draw(g,t,W,H)`. Use só a API `L` (`references/api.md`).
5b. **Lint**: `node scripts/lint.mjs meu_video` (proibidos, escala, CONFIG) e confira `references/escala.md`.
6. **Revise por contact sheet antes de renderizar**: `node scripts/render.mjs meu_video --snap 0.3,1,2,3.5,5 --cols 3 --out contact.png` e OLHE a imagem (Read). Corrija cortes, textos fora da tela, braços cruzando, sobreposição.
6b. **Som (motor `audio/`)**: copie `templates/audio.json` para o projeto e preencha: `music.style` (alegre|aventura|lofi|suspense|toon|mercado), `ambience` (rua|campo|loja|escritorio|noite), `captions` (legenda por texto, legenda = fala) e `voices` (só reações de personagem em balbucio; narração = `voice_file` do usuário) e `sfx` nos tempos das ações (34 efeitos em `audio/sfx_lib.py`). Melhor ainda: declare `window.HITS=[[t,'pop'],[t,'bonk',{pan:.3}],…]` no `cena.js` (cada momento que o desenho "acende") e rode `node scripts/render.mjs meu_video --hits meu_video/hits.json` — o som nasce da imagem e não dessincroniza. Depois: `bash scripts/audio.sh meu_video` → `mix.wav` (voz sempre por cima, música com ducking, **-14 LUFS / -1,2 dBTP**) + `relatorio_audio.md` (a margem voz−fundo deve ser ≥ 8 LU). A voz neural (`tts:true`) está desligada por soar português de Portugal; narração = `voz.mp3` do usuário. Detalhes: `references/audio.md`.
6c. **Verificador automático de enquadramento**: `python3 scripts/composicao.py meu_video --n 12` (corte na borda, cena deslocada, espaço vazio, cena parada). Corrija todo ⚠/✗ antes de seguir.
6d. **Ciclo de crítica (mínimo 2 rodadas; 3 em vídeo > 20 s)**: contact sheet normal + `--phone` (folha miniatura = celular a um braço de distância) + `--strip a,b,8` em cada transição. Dê nota 1–10 para: gancho, leitura no celular, qualidade do movimento, variedade, consistência de escala/personagem, sincronia do som. Corrija os 3 piores e repita até todas as notas ≥ 8. Registre em `critique.md`. Detalhes: `references/estudio.md`.
7. **Renderize** (versão final com motion blur de cinema): `node scripts/render.mjs meu_video --out video.mp4 --audio meu_video/mix.wav --blur 3`. O script lista erros de JS no fim — deve ser zero.
8. **QA** (`references/qa.md`): `bash scripts/qa_video.sh video.mp4` (áudio, preto, trechos parados, folha de contato) e chame os revisores que não viram o trabalho: `detalhista` (cético, tolerância zero, com evidência de quadros; `agents/detalhista.md`), `audio-qa` (mede loudness, sincronia e efeitos) e `animation-qa` (`bash install.sh claude` instala os dois em `~/.claude/agents/`; em outros agentes use `agents/universal/*.md`). Corrija o que ele reprovar e reveja. Depois: confira 3 frames do MP4 final com ffmpeg, duração = áudio, tamanho de arquivo, áudio presente.
9. **Entregue** o MP4 e diga em 2 linhas o que foi feito.

## Regras duras (evitam 95% dos erros)
- **Pura em t**: PROIBIDO `Math.random`, `Date.now`, `setTimeout`, `requestAnimationFrame`, estado acumulado entre frames. Aleatório = `L.hash(i)`.
- **Entradas com mola**: `L.spring(t - t0)` (0→1 com leve overshoot) em vez de aparecer do nada. Escala/posição, nunca só opacidade.
- **Personagem com AÇÃO**: cada cena tem uma sequência (chega andando → faz algo → reage). Nunca só uma pose parada.
- **Sempre algo se mexendo**: respiração, flutuação (`Math.sin`), grama balançando, nuvens, estrada rolando. Cena parada = vídeo morto.
- **Safe area 9:16**: nada importante nos 150 px de cima nem nos 380 px de baixo (UI do Shorts). Legenda em y≈ 0.70·H.
- **Legendas**: palavra por palavra, grossas, contorno escuro, 1 palavra destacada em amarelo (`L.captions`). Máx. 3 palavras por grupo.
- **Personagens ORIGINAIS**. Não copie personagens, mascotes ou logos de terceiros (nem "parecidos"). Logo de marca só se o usuário enviar o arquivo; aí use `drawImage`.
- **Escala e construção**: pessoa (1,7 m) sempre menor que casa/porta/carro (4,2 m); rua e calçada coladas; tudo no chão com sombra. Ao mexer no cenário, REVISE os personagens (e vice-versa). Tabela em `references/escala.md`.
- **Nunca** reproduza ou remova marca d'água de terceiros. Se o usuário pedir a marca do canal, use o PNG dele, pequeno no canto (≈ 8% da largura), sem fundo.
- **Fontes**: `Archivo Black`/`Anton` podem não existir na máquina; o código cai para Impact/DejaVu Sans. Se quiser a fonte exata, instale-a (`fc-cache`) ou carregue via `@font-face` com arquivo local ANTES de `READY`.
- **Resolução**: renderize no tamanho final. Teste rápido com `--scale .5 --from 0 --to 3`.
- **Acabamento**: `L.finish` (bloom, grade, vinheta, grão) já roda no `index.html`; enquadre perto, 3 planos de profundidade, foco ≥ 55% da altura útil (`references/composicao.md`).
- Não declare "pronto" sem ter visto os frames e sem o `detalhista` aprovar.

## Regras de estúdio (vieram do estudo de motion-reel; valem para todo vídeo)
- **Corte na batida**: o quadro do corte já mostra a imagem nova (nunca um quadro vazio/flash). Flash branco só 1–2× no vídeo (virada e final); flash em todo corte = cara de template.
- **Algo novo a cada 2–4 s** (ação, câmera, objeto, texto). Entradas com direção, peso e motivo; nada de "tudo aparece com fade".
- **Proibido (cara de template)**: título centralizado em gradiente, tudo com fade-in, cantos decorativos, brilho (glow) em tudo, rajada genérica de partículas.
- **Zoom em log** (`L.zoomLog(a,b,p)`): dolly constante, não "demora grande". **Impacto** = `L.shake(t,t0)` + `L.wobble(t-t0)` (esmaga e assenta) + SFX no mesmo quadro.
- **Whip** = pan com as duas cenas na tela (A sai enquanto B entra), nunca duas meias-câmeras com vazio no meio.
- **Duas fontes no máximo**, uma cor de destaque. Todo texto precisa sobreviver à folha `--phone`.
- **Som sai da imagem** (`window.HITS`) e o master é -14 LUFS; voz ≥ 8 LU acima do fundo.

## Arquivos
- `AGENTS.md` / `CLAUDE.md` / `GEMINI.md` (instruções por agente), `install.sh`, `chatgpt/INSTRUCOES.md`, `LICENSE`, `CHANGELOG.md`, `agents/` (detalhista, animation-qa, `universal/`), `references/composicao.md` (enquadramento/acabamento), `references/3d.md` (roteiro 3D).
- `audio/` — motor de áudio: `dsp.py` (filtros, reverb, LUFS, limiter), `sfx_lib.py` (34 efeitos), `voice.py` (10 vozes de personagem), `music.py` (6 estilos), `mix.py` (mixagem + relatório). `templates/audio.json` é o modelo. `references/audio.md`, `references/estudio.md`.
- `PROMPT_MESTRE.md` modelo de pedido (história, duração, formato, estilo...) • `references/escala.md` medidas e construção • `scripts/lint.mjs` checagem antes de renderizar • `templates/toon.js` gato x rato (demo `demos/toon`)
- `templates/stick.js` bonecos palito + escritório/quarto japonês (demo `demos/palito`)
- `templates/mercado.js` interior de mercado animado • `references/detalhes.md` checklist de micro-detalhes
- `templates/shop.js` loja isométrica pronta: `shopScene(g,t,W,H,SHOP_BLUE|SHOP_BAKERY|SHOP_PHARMA)` (troque só o objeto de cores/textos) • `demos/` 4 vídeos de 10 s (mercadinho, padaria, menino, mercado) com fonte
- `templates/` projeto base • `exemplo/` 3 cenas prontas (flat+robô, mercadinho iso, campo) com MP4 e contact sheet
- `references/api.md` funções do `L` • `estilos.md` receitas dos 4 estilos • `personagens.md` rig/expressões • `cenarios.md` • `legendas.md` • `qa.md` • `prompts.md`
- `scripts/render.mjs` render/snap • `prep_audio.py` palavras+envelope • `check.sh`
