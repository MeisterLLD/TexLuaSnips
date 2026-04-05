# Snippets LuaSnip — LaTeX

Snippets LuaSnip pour LaTeX, pensés pour une utilisation avec [vimtex](https://github.com/lervag/vimtex) et Neovim. La plupart des snippets math ne se déclenchent qu'en zone mathématique (détection automatique via vimtex).

## Prérequis

- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [vimtex](https://github.com/lervag/vimtex) (pour la détection de zone mathématique)
- Configuration dans init.lua d'une touche "Store Selection Keys" pour pouvoir éxécuter un snippet depuis une sélection visuelle, par exemple
  ```
  { "L3MON4D3/LuaSnip",
	config = function()
	  require("luasnip").setup({
	    enable_autosnippets = true,
	    store_selection_keys = "<Tab>",
	  })
	  require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
        end,
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp"
    },
  ```
- Configuration dans init.lua d'une touche pour compléter les snippets non autoSnippets, par exemple
  ```
  vim.keymap.set("i", "<Space>", function()
    if require("luasnip").expandable() then
      require("luasnip").expand()
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Space>", true, false, true), "n", false)
    end
  end)
  ```
  et d'une touche pour sauter entre les nœuds (par exemple : les deux bornes d'une intégrale, le contenu, la lettre après le \mathrm{d}, etc. Par exemple :
```
vim.keymap.set({"i","s"}, "<Tab>", function()
  if require("luasnip").locally_jumpable(1) then
    require("luasnip").jump(1)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end)
```
## Installation

Copiez le fichier dans votre répertoire de snippets LuaSnip, par exemple :

```
~/.config/nvim/lua/snippets/tex.lua
```

Puis dans votre config LuaSnip :

```lua
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
```

---

## Conventions générales

| Préfixe | Usage |
|--------|-------|
| `;` | Symboles et délimiteurs **math** |
| `,` | Commandes **texte/structure** (alias pour certains triggers) |
| `E__` | **Environnements** LaTeX |
| `F__` | **Fontes** (mise en forme texte) |
| Majuscules | Commandes **math** (opérateurs, accents…) |

La plupart des snippets qui enveloppent du contenu supportent la **sélection visuelle** : sélectionnez du texte → Tab → trigger → le texte est automatiquement enveloppé.

---

## Lettres grecques

Se déclenchent uniquement en zone math. Format : `;` + lettre.

| Trigger | Résultat |
|---------|----------|
| `;a` | `\alpha` |
| `;b` | `\beta` |
| `;g` | `\gamma` |
| `;d` | `\delta` |
| `;e` | `\varepsilon` |
| `;z` | `\zeta` |
| `;t` | `\theta` |
| `;i` | `\iota` |
| `;k` | `\kappa` |
| `;l` | `\lambda` |
| `;m` | `\mu` |
| `;n` | `\nu` |
| `;x` | `\xi` |
| `;p` | `\pi` |
| `;r` | `\rho` |
| `;s` | `\sigma` |
| `;u` | `\upsilon` |
| `;q` | `\chi` |
| `;y` | `\psi` |
| `;v` | `\varphi` |
| `;w` | `\omega` |

---

## Environnements

| Trigger | Résultat |
|---------|----------|
| `BEG` | `\begin{…} \end{…}` générique (le nom est recopié automatiquement) |
| `EEN` | `enumerate` avec un `\item` |
| `EIT` | `itemize` avec un `\item` |
| `EEQ` | `equation` avec `\label{eq:…}` |
| `ALI` | `align*` (supporte la sélection visuelle) |
| `FIG` | `figure` avec `\centering`, `\caption`, `\label` |
| `CAS` | `cases` |
| `PMAT` | `pmatrix` 2×2 |
| `CEN` | `center` (supporte la sélection visuelle multiligne) |
| `APA` | `apart` (environnement custom, supporte la sélection visuelle multiligne) |
| `MIN` | Bloc `minted` python (supporte la sélection visuelle, sans indentation forcée) |

---

## Fractions et opérateurs

| Trigger | Résultat |
|---------|----------|
| `;/` | `\frac{…}{…}` (numérateur = sélection visuelle) |
| `SUM` | `\sum_{…}^{…}` |
| `INT` | `\int_{…}^{…} … \mathrm{d}x` |
| `LIM` | `\lim\limits_{x \to …}` |
| `PRD` | `\prod_{…}^{…}` |
| `SQR` | `\sqrt{…}` |
| `BIN` | `\binom{…}{…}` |
| `CDT` | `\cdot` |
| `TMS` | `\times` |
| `TVV` | `… \underset{x \to a}{\longrightarrow} L` — "tend vers" (à déclencher après avoir écrit l'expression) |

---

## Exposants et indices

| Trigger | Résultat | Note |
|---------|----------|------|
| `^^` | `^{…}` | Autosnippet |
| `_` | `_{…}` | Snippet manuel (Tab) |

---

## Délimiteurs (sélection visuelle supportée)

Tous se déclenchent uniquement en zone math, sauf les guillemets français.

| Trigger | Résultat |
|---------|----------|
| `;(` ou `((` | `\left( … \right)` |
| `;[` | `\left[ … \right]` |
| `;{` ou `{{` | `\left\{ … \right\}` |
| `\|\|` | `\left\| … \right\|` (valeur absolue) |
| `NRM` | `\left\\| … \right\\|` (norme) |
| `;"` | `\og … \fg{}` (guillemets français) |

### Intervalles

| Trigger | Résultat |
|---------|----------|
| `[[` | `\left[ … \right[` |
| `[]` | `\left[ … \right]` |
| `][` | `\left] … \right[` |

---

## Symboles

| Trigger | Résultat |
|---------|----------|
| `oo` | `\infty` |
| `!=` | `\neq` |
| `=>` | `\implies` |
| `<=>` | `\iff` |
| `->` | `\to` |
| `!>` | `\mapsto` |
| `;<` | `\leq` |
| `;>` | `\geq` |
| `;c` | `\subset` |
| `;)` | `\supset` |
| `FA` | `\forall` |
| `EX` | `\exists` |
| `...` | `\dots` |

---

## Mode math

| Trigger | Résultat |
|---------|----------|
| `mk` | `$…$` inline (sélection visuelle) |
| `$$` | `\[ … \]` display (sélection visuelle) |
| `;$` | Inline ou display selon la sélection (sélection linewise → display) |

---

## Fontes texte (sélection visuelle supportée)

| Trigger | Résultat |
|---------|----------|
| `FEM` | `\emph{…}` |
| `FIT` | `\textit{…}` |
| `FBF` | `\textbf{…}` |
| `FTT` | `\texttt{…}` |

---

## Mathématiques avancées

| Trigger | Résultat |
|---------|----------|
| `MCa` | `\mathcal{A}` (la lettre tapée est capturée, ex : `MCr` → `\mathcal{R}`) |
| `MBa` | `\mathbb{A}` (même principe, ex : `MBr` → `\mathbb{R}`) |
| `OVR` | `\overset{…}{…}` (sélection visuelle sur la base) |
| `UDR` | `\underset{…}{…}` (sélection visuelle sur la base) |
| `UBR` | `\underbrace{…}_{…}` (sélection visuelle sur le contenu) |
| `TEX` | `\text{…}` (dans une équation) |

---

## Structure du document

| Trigger | Résultat |
|---------|----------|
| `SSE` | `\section{…}` |
| `SSS` | `\subsection{…}` |
| `SSSS` | `\subsubsection{…}` |
| `ITM` ou `,it` | `\item` |
| `,exo` | `\exercice{…}` |
| `MIT` | `\mintinline{python}{…}` (sélection visuelle) |

---

## Personnalisation

L'indentation est définie par la variable `indent` en haut du fichier :

```lua
local indent = "  "  -- remplacer par "\t" ou "    " selon préférence
```
