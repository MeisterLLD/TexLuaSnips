# Snippets LuaSnip — LaTeX

Snippets LuaSnip pour LaTeX, pensés pour une utilisation avec [vimtex](https://github.com/lervag/vimtex) et Neovim. 

Les snippets sont des suites de touches à taper dans neovim et qui ont un effet sur le texte en cours d'édition. Le but est de réduire l'utilisation des macros persos afin de faciliter la compatibilité et le partage de fichiers. 

La philosophie est la suivante : remplacer une macro LaTeX par un snippet qui va écrire la commande en entier. L'auteur y gagne aussi au change car les snippets sont faciles à taper (seulement quelques touches, aucune combinaison type \ ou { etc)).

La plupart des snippets math ne se déclenchent qu'en zone mathématique (détection automatique via vimtex).

Beaucoup de snippets ont des nœuds : on peut voyager entre les différentes zones de la commande à l'aide de touches configurées dans LuaSnip (par exemple les deux bornes et le contenu d'une somme) ainsi que sortir de la commande par cette même touche.


## Prérequis

- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [vimtex](https://github.com/lervag/vimtex) (pour la détection de zone mathématique)

## Installation

Copiez le fichier dans votre répertoire de snippets LuaSnip, par exemple :

```
~/.config/nvim/lua/snippets/tex.lua
```

Puis dans votre config LuaSnip :

```lua
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
```
Configurer aussi LuaSnip pour
- activer les autosnippets
- configurer une touche store_selection_keys (Tab dans les exemples ci-dessous)
- une touche ou combinaison pour avancer ou reculer dans les nœuds (p. ex Tab et Shift+Tab).

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
| `CIR` | `\circ` |
| `TVV` | `… \underset{x \to a}{\longrightarrow} L` — "tend vers" (à déclencher après avoir écrit l'expression) |
| `DER` | `\frac{\mathrm{d}}{\mathrm{d}x} …` — dérivée (variable paramétrable) |
| `PAR` | `\frac{\partial …}{\partial x}` — dérivée partielle |

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
| `ENT` | `[\![ … , … ]\!]` (intervalle d'entiers) |
| `SET` | `\left\{ … \middle\| … \right\}` (ensemble en compréhension, barre adaptive) |

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
| `SSI` | `\ \Leftrightarrow \ ` |
| `->` | `\to` |
| `!>` | `\mapsto` |
| `;<` | `\leq` |
| `;>` | `\geq` |
| `;c` | `\subset` |
| `;)` | `\supset` |
| `FA` | `\forall` |
| `EX` | `\exists` |
| `...` | `\dots` |
| `CAP` | `\cap` |
| `CUP` | `\cup` |
| `IIN` | `\in` |
| `VID` | `\varnothing` |
| `BCAP` | `\bigcap_{…}` |
| `BCUP` | `\bigcup_{…}` |
| `COL` | `\colon` |


---

## Arithmétique

|Trigger | Résultat |
|--------|----------|
| `WED` | `\wedge` |
| `VEE` | `\vee` |
| `MOD` | `\equiv … [n]` — congruence (notation française) |

---

## Complexes
|Trigger | Résultat |
|--------|----------|
| `RE` | `\mathrm{Re}(…)` — partie réelle |
| `ARG` | `\mathrm{arg}(…)` — argument |
| `BAR` | `\overline{…}` — conjugué ou adhérence |

---

## Analyse asymptotique

| Trigger | Résultat |
|---------|----------|
| `PO` | `\underset{x \to a}{o}(…)` — petit o |
| `GO` | `\underset{x \to a}{O}(…)` — grand O |
| `EQ` | `\underset{x \to a}{\sim} …` — équivalent |

---

## Mode math

| Trigger | Résultat |
|---------|----------|
| `mk` | `$…$` inline  |
| `$$` | `\[ … \]` display |
| `;$` | Inline ou display selon la sélection (sélection linewise → display) |

---

## Texte (sélection visuelle supportée)

| Trigger | Résultat |
|---------|----------|
| `FEM` | `\emph{…}` |
| `FIT` | `\textit{…}` |
| `FBF` | `\textbf{…}` |
| `FTT` | `\texttt{…}` |
| `FBO` | `\fbox{…}` — encadré texte |
| `BOX` | `\boxed{…}` — encadré mode math |
| `,,` | `,\ ` — virgule suivie d'une espace en mode math |

---

## Mathématiques autres

| Trigger | Résultat |
|---------|----------|
| `MCA` | `\mathcal{A}` (la lettre tapée est capturée, ex : `MCC` → `\mathcal{C}`) |
| `MBA` | `\mathbb{A}` (même principe, ex : `MBZ` → `\mathbb{Z}`) |
| `RR` | `\mathbb{R}`| 
| `CC` | `\mathbb{C}`| 
| `KK` | `\mathbb{K}`| 
| `NN` | `\mathbb{N}`| 
| `ZZ` | `\mathbb{Z}`| 
| `OVR` | `\overset{…}{…}` (sélection visuelle sur la base) |
| `UDR` | `\underset{…}{…}` (sélection visuelle sur la base) |
| `UBR` | `\underbrace{…}_{…}` (sélection visuelle sur le contenu) |
| `TEX` | `\text{…}` (dans une équation) |
| `IINF` | `\inf_{…}` |
| `SSUP` | `\sup_{…}` |
| `MMAX` | `\max_{…}` |
| `MMIN` | `\min_{…}` |
| `ID` | `\mathrm{Id}_{…}` — application identité |
| `ZER` | `\mathrm{0}_{…}` — zéro d'un espace |
| `ELL` | `\ell` |
| `RNG` | `\mathring{…}` — intérieur d'un ensemble |

---

## Algèbre linéaire
| Trigger | Résultat |
|---------|----------|
| `IM` | `\mathrm{Im}(…)`  |
| `KER` | `\mathrm{Ker}(…)`  |
| `DET` | `\mathrm{det}(…)`  |
| `TR` | `\mathrm{tr}(…)`  |
| `DIM` | `\dim(…)`  |
| `OPL` | `\oplus` |
| `BOP` | `\bigoplus_{…}` |
| `LL` | `\mathcal{L}(…)` |

---

## Probabilités

| Trigger | Résultat |
|---------|----------|
| `PP` | `\mathbf{P}(…)` — probabilité  |
| `EE` | `\mathbf{E}[…]` — espérance  |
| `VV` | `\mathbf{V}(…)` — variance  |

---

## Structure du document

| Trigger | Résultat |
|---------|----------|
| `SSE` | `\section{…}` |
| `SSS` | `\subsection{…}` |
| `SSSS` | `\subsubsection{…}` |
| `ITM` ou `,it` | `\item` |
| `,exo` | `\exercice{…}` |
| `MIT` | `\mintinline{python}{…}`  |
| `LBL` | `\label{…}`  |
| `REF` | `\ref{…}`  |

---

## Personnalisation

L'indentation est définie par la variable `indent` en haut du fichier :

```lua
local indent = "  "  -- remplacer par "\t" ou "    " selon préférence
```
