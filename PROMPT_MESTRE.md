# 🎬 PROMPT MESTRE — Astawow 2D Animator
> Agora ele já vem **embutido no SKILL.md** (seção MODO PEDIDO): dá pra pedir direto em uma frase ou usar `/animar`. Este arquivo continua aqui como formulário completo para colar.
Copie o bloco abaixo, troque o que está entre `[colchetes]` e cole no Claude Code (com a skill `astawow-2d-animator` instalada).
Pode apagar as linhas que não quiser preencher: o Claude escolhe o melhor sozinho e avisa o que decidiu.

```
Use a skill astawow-2d-animator e crie um vídeo de animação 2D completo, do roteiro ao MP4 final.

HISTÓRIA: [conte a história em 3 a 8 frases — começo, meio e fim com uma virada ou piada]
DURAÇÃO: [ex.: 10 s | 30 s | 60 s]
FORMATO: [vertical 9:16 (Shorts/TikTok/Reels) | horizontal 16:9 (YouTube) | quadrado 1:1]
ESTILO: [escolha UM:
  • flat-vector (explicador com robô e fundo de bolinhas)
  • iso-loja (mercadinho/padaria/farmácia/rua em low-poly isométrico)
  • mercado-por-dentro (interior do mercado: prateleira, carrinho, caixa)
  • campo (menino bolinha preto e branco sob a árvore)
  • boneco-palito (escritório / quarto, cabeção redondo, tracinho preto)
  • desenho-de-perseguição (gato x rato, slapstick, estilo desenho clássico)]
PERSONAGENS: [nome, aparência, personalidade — ou "crie você"]
CENÁRIO: [onde acontece — ou "crie você"]
NARRAÇÃO: [anexei voz.mp3 e roteiro.txt | sem narração, só legenda | crie o texto]
LEGENDAS: [sim, palavra por palavra com destaque na cor #ff8a3d | não]
IDIOMA: [pt-BR]
FINAL: [ex.: chamada "INSCREVA-SE" | iris-out "FIM" | sem final especial]
MARCA D'ÁGUA: [anexei logo.png, pequena no canto | não]
EXTRAS: [música? efeitos? algo especial que você quer ver]

REGRAS (obrigatórias):
1. Leia o SKILL.md e as referências (escala.md, detalhes.md, estilos.md, qa.md) antes de começar.
2. Primeiro me mostre a LISTA DE CENAS (tempo de cada uma, o que acontece, qual câmera) em 6 a 10 linhas e siga em frente sem esperar, a menos que falte algo essencial.
3. Cada cena tem AÇÃO (o personagem chega → faz algo → reage). Nada de pose parada.
4. Escala correta: pessoa menor que a casa/porta/carro, carro com 4 m, rua e calçada coladas, tudo apoiado no chão com sombra. Use a tabela de references/escala.md.
5. Personagens e cenários ORIGINAIS. Não copie personagem, mascote nem logo de terceiros.
6. Se mexer no cenário, revise também os personagens (e vice-versa).
7. Antes de renderizar: `node scripts/lint.mjs <projeto>`. Depois contact sheet com 8 a 12 frames — olhe e corrija (texto cortado, sobreposição, personagem fora de escala, elemento parado).
8. Renderize no tamanho final, confira com ffprobe (duração, resolução, áudio) e extraia 3 frames do MP4 para conferir.
9. Entregue o MP4 (e o contact sheet). Diga em 3 linhas o que fez e o que decidiu por conta própria.
```

## Exemplos prontos (preenchidos)
**Mercadinho (Shorts de 10 s)** — HISTÓRIA: "Um cliente descobre que o mercadinho do bairro é mais barato que o supermercado e leva a sacola feliz." DURAÇÃO: 10 s. FORMATO: vertical. ESTILO: iso-loja (azul). LEGENDAS: sim.

**Perseguição (YouTube, 30 s)** — HISTÓRIA: "O gato acorda, o rato rouba o queijo, a perseguição passa pela cozinha e acaba com o gato dentro da geladeira." DURAÇÃO: 30 s. FORMATO: horizontal. ESTILO: desenho-de-perseguição. FINAL: iris-out "FIM".

**Palito (TikTok, 15 s)** — HISTÓRIA: "O chefe aparece de surpresa pelo teto na reunião." ESTILO: boneco-palito. FORMATO: vertical.

## Versão curta (para outras IAs)
```
Você é um animador 2D por código. Instale/leia a skill astawow-2d-animator (SKILL.md e references/). Crie um vídeo de [DURAÇÃO] s, [vertical|horizontal], estilo [ESTILO], sobre: [HISTÓRIA]. Siga o fluxo da skill, respeite references/escala.md, rode scripts/lint.mjs e o contact sheet, renderize e entregue o MP4.
```
