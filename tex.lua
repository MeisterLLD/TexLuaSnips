local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local greek_letters = {
    a = "alpha",
    b = "beta",
    g = "gamma",
    d = "delta",
    e = "varepsilon",
    z = "zeta",
    t = "theta",
    i = "iota",
    k = "kappa",
    l = "lambda",
    m = "mu",
    n = "nu",
    x = "xi",
    p = "pi",
    r = "rho",
    s = "sigma",
    u = "upsilon",
    q = "chi",
    y = "psi",
    v = "varphi",
    w = "omega",
}



local indent = "  "  -- changer ici pour 4 espaces ou \t

local function copy(args)
	return args[1]
end

local function visual_or_empty(args, parent)
    -- Récupère la sélection visuelle si elle existe, sinon retourne un insert node vide
    local visual = parent.env.TM_SELECTED_TEXT or {}
    if #visual > 0 then
        return sn(nil, { t(visual) })
    else
        return sn(nil, { i(1) })
    end
end


local in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local snippets = { 
    -- Snippet BEG générique
    s({ trig = "BEG", snippetType = "autosnippet", dscr = "Environnement LaTeX générique" }, {
        t("\\begin{"), i(1, "env"), t({ "}", indent }),
        i(2), -- Le contenu de l'environnement
        t({ "", "\\end{" }),
        f(copy, {1}), -- Recopie automatiquement ce qui est tapé en i(1)
        t({ "}", "" }),
        i(0), -- Sortie propre à la ligne en dessous
    }),


    -- Snippet pour l'environnement Enumerate (EEN)
    s({ trig = "EEN", snippetType = "autosnippet", dscr = "Environnement enumerate avec un item" }, {
        t({ "\\begin{enumerate}", indent .. "\\item " }),
        i(1), -- Le curseur commence ici après l'item
        t({ "", "\\end{enumerate}", "" }),
        i(0), -- Sortie du snippet (après le end)
    }),

    -- Snippet pour l'environnement Itemize (EIT)
    s({ trig = "EIT", snippetType = "autosnippet", dscr = "Environnement itemize avec un item" }, {
        t({ "\\begin{itemize}",  indent .. "\\item " }),
        i(1), -- Le curseur commence ici après l'item
        t({ "", "\\end{itemize}", "" }),
        i(0), -- Sortie du snippet (après le end)
    }),

    -- Snippet pour l'environnement Equation (EEQ)
     s({ trig = "EEQ", snippetType = "autosnippet", dscr = "Equation" }, {
        t({ "\\begin{equation}", indent .. "\\label{eq:" }), i(1, "nom"), t("}"),
        t({ "", indent }), i(2), -- Le contenu de l'équation
        t({ "", "\\end{equation}", "" }),
        i(0) -- Sortie finale sous l'équation
    }),

     s({ trig = "ALI", snippetType = "autosnippet", dscr = "Align*" }, {
	t({ "\\begin{align*}", indent }),
	d(1, visual_or_empty),
	t({ "", "\\end{align*}", "" }),
	i(0)
    }),

    s({trig = "FIG", snippetType = "autosnippet", name = "LaTeX Figure"}, {
        t({"\\begin{figure}[h!]", ""}),
        t({indent .. "\\centering", indent .. "\\includegraphics[width=0.8\\linewidth]{"}),
        i(1, "file"), -- Nœud 3 : Nom du fichier
        t({"}", indent .. "\\caption{"}),
        i(2, "caption"), -- Nœud 4 : Légende
        t({"}", indent .. "\\label{fig:"}),
        i(3, "label"), -- Nœud 5 : Label (préfixé par fig:)
        t({"}", "\\end{figure}", ""}),
        i(0) -- Nœud final : Sortie une ligne après le \end{figure}
    }),

    -- fraction
  s({trig = ";/", snippetType = "autosnippet", condition = in_mathzone, wordTrig = false  }, {
    t("\\frac{"),
    d(1, visual_or_empty),
    t("}{"),
    i(2),
    t("} "),
    i(0),
  }),


    --- EXPOSANTS ET INDICES (Manuel : ^ + Espace/Tab)
    s({ trig = "%^%^?", snippetType= "autosnippet", regTrig = true, wordTrig = false, dscr = "Exposant" }, { t("^{"), i(1), t("}") }),
    s({ trig = "_", wordTrig = false, dscr = "Indice" }, { t("_{"), i(1), t("}") }),

    --- SYMBOLES (Autosnippets)
    s({ trig = "oo", snippetType = "autosnippet", condition = in_mathzone }, { t("\\infty ") }),
    s({ trig = "=>", snippetType = "autosnippet", condition = in_mathzone, wordTrig = false  }, { t("\\implies ") }),
    s({ trig = "SSI", snippetType = "autosnippet", condition = in_mathzone }, { t("\\ \\Leftrightarrow \\ ") }),
    s({ trig = "...", snippetType = "autosnippet", condition = in_mathzone }, { t("\\dots") }),
    s({ trig = "!=", snippetType = "autosnippet", condition = in_mathzone, wordTrig = false  }, { t("\\neq ") }),
    s({ trig = ";<", snippetType = "autosnippet", condition = in_mathzone, wordTrig = false }, { t("\\leq ") }),
    s({ trig = ";>", snippetType = "autosnippet", condition = in_mathzone, wordTrig = false  }, { t("\\geq ") }),
    s({ trig = ";c", snippetType = "autosnippet", condition = in_mathzone, wordTrig = false  }, { t("\\subset ") }),
    s({ trig = ";)", snippetType = "autosnippet", condition = in_mathzone, wordTrig = false  }, { t("\\supset ") }),
    s({ trig = "->", snippetType = "autosnippet", condition = in_mathzone, wordTrig = false  }, { t("\\to ") }),
    s({ trig = "!>", snippetType = "autosnippet", condition = in_mathzone, wordTrig = false  }, { t("\\mapsto ") }),
    s({ trig = "FA", snippetType = "autosnippet", condition = in_mathzone }, { t("\\forall ") }),
    s({ trig = "EX", snippetType = "autosnippet", condition = in_mathzone }, { t("\\exists ") }),

    --- OPÉRATEURS
    s({ trig = "SUM", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\sum_{"), i(1, "n=1"), t("}^{"), i(2, "\\infty"), t("} "), i(0)
    }),
    s({ trig = "LIM", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\lim\\limits_{"), i(1, "x"), t(" \\to "), i(2, "\\infty"), t("} "), i(0)
    }),
    s({ trig = "INT", snippetType = "autosnippet", condition = in_mathzone }, {
        t("\\int_{"), i(1, "-\\infty"), t("}^{"), i(2, "\\infty"), t("} "), 
        i(3), 
        t(" \\mathrm{d} "), i(4, "x"), 
        i(0)
    }),

    -- Sections
    s({trig = "SSE", snippetType = "autosnippet", name = "Section"}, {
	t("\\section{"),
	i(1, "titre"),
	t({"}", ""}),
	i(0) -- Curseur placé après la section

    }),

    s({trig = "SSS", snippetType = "autosnippet", name = "Subsection"}, {
	t("\\subsection{"),
	i(1, "titre"),
	t({"}", ""}),
	i(0) -- Curseur placé après la section

    }),


    -- Fontes
      -- FEM -> \emph{...}
    s({ trig = "FEM", snippetType = "autosnippet", dscr = "Emphase (italique logique)" }, {
      t("\\emph{"), d(1, visual_or_empty), t("}"), i(0)
    }),

    s({ trig = "FIT", snippetType = "autosnippet", dscr = "Texte en italique" }, {
      t("\\textit{"), d(1, visual_or_empty), t("}"), i(0)
    }),

    s({ trig = "FTT", snippetType = "autosnippet", dscr = "Texte en police machine à écrire" }, {
      t("\\texttt{"), d(1, visual_or_empty), t("}"), i(0)
    }),

    s({ trig = "FBF", snippetType = "autosnippet", dscr = "Texte en gras" }, {
      t("\\textbf{"), d(1, visual_or_empty), t("}"), i(0)
    }),


    -- Autres
    -- ,it → \item 
    s({trig = ",it", snippetType = "autosnippet"}, {
      t("\\item "),
      i(1),
    }),
    
    s({trig = "ITE", snippetType = "autosnippet"}, {
      t("\\item "),
      i(1),
    }),

    -- ,exo → \exercice{...}
    s({trig = ",exo", snippetType = "autosnippet"}, {
      t("\\exercice{"),
      i(1),
      t({"}", ""}),
      i(2),
    }),


    s({ trig = "MC(%a)", snippetType = "autosnippet", regTrig = true, wordTrig = false, condition = in_mathzone }, {
	f(function(_, snip)
	  return "\\mathcal{" .. snip.captures[1]:upper() .. "} "
	end)
    }),


    s({ trig = "MB(%a)", snippetType = "autosnippet", regTrig = true, wordTrig = false, condition = in_mathzone}, {
	f(function(_, snip)
	  return "\\mathbb{" .. snip.captures[1]:upper() .. "} "
	end)
    }),


    s({ trig = "$$", snippetType = "autosnippet", dscr = "Équation hors-texte", wordTrig = false  }, {
        t("\\[ "), d(1, visual_or_empty), t({ " \\]", "" }),
	i(0)
    }),


    s({ trig = "mk", snippetType = "autosnippet", wordTrig = false  }, {
	t("$"), d(1, visual_or_empty), t("$"), i(0)
    }),

    s({ trig = "PMAT", snippetType = "autosnippet", dscr = "Matrice parenthèses 2x2",  condition = in_mathzone }, {
      t({"\\begin{pmatrix}", indent }),
      i(1), t(" & "), i(2), t({ " \\\\", indent }),
      i(3), t(" & "), i(4), t({ " ", "\\end{pmatrix}" }),
      i(0)
    }),

    s({ trig = "MIT", snippetType = "autosnippet" }, {
      t("\\mintinline{python}{"),
      d(1, visual_or_empty),
      t("} "),
    }),

    -- MIT -> bloc minted python
    s({ trig = "MIN", snippetType = "autosnippet" }, {
      t({ "\\begin{minted}{python}", "" }),
      d(1, visual_or_empty),
      t({ "", "\\end{minted}", "" }),
    }),



    -- Valeur absolue
    s({ trig = "||", snippetType = "autosnippet", condition = in_mathzone, wordTrig = false  }, {
      t("\\left| "), d(1, visual_or_empty), t(" \\right| "), i(0)
    }),

    -- Norme
    s({ trig = "NRM", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\left\\| "), d(1, visual_or_empty), t(" \\right\\| "), i(0)
    }),

    -- Racine carrée
    s({ trig = "SQR", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\sqrt{"), d(1, visual_or_empty), t("} "), i(0)
    }),

    -- \text{} dans une équation
    s({ trig = "TEX", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\text{"), d(1, visual_or_empty), t("} "), i(0)
    }),

    -- Binomial
    s({ trig = "BIN", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\binom{"), i(1), t("}{"), i(2), t("} "), i(0)
    }),

    -- Opérateurs
    s({ trig = "CDT", snippetType = "autosnippet", condition = in_mathzone }, { t("\\cdot ") }),
    s({ trig = "TMS", snippetType = "autosnippet", condition = in_mathzone }, { t("\\times ") }),



    -- Cases
    s({ trig = "CAS", snippetType = "autosnippet", condition = in_mathzone }, {
      t({ "\\begin{cases}", indent }),
      i(1), t(" & \\text{si } "), i(2),
      t({ " \\\\", indent }),
      i(3), t(" & \\text{sinon}"),
      t({ "", "\\end{cases}" }),
      i(0)
    }),

    -- Subsubsection
    s({trig = "SSSS", snippetType = "autosnippet", name = "Subsubsection"}, {
      t("\\subsubsection{"),
      i(1, "titre"),
      t({"}", ""}),
      i(0)
    }),


	-- \overset{}{} 
    s({ trig = "OVR", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\overset{"), i(1), t("}{"),
      d(2, visual_or_empty),
      t("} "), i(0)
    }),

    -- \underset{}{}
    s({ trig = "UDR", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\underset{"), i(1), t("}{"),
      d(2, visual_or_empty),
      t("} "), i(0)
    }),

    -- \prod
    s({ trig = "PRD", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\prod_{"), i(1, "n=1"), t("}^{"), i(2, "\\infty"), t("} "), i(0)
    }),

    s({ trig = "UBR", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\underbrace{"),
      d(1, visual_or_empty),
      t("}_{"),
      i(2),
      t("} "),
      i(0)
    }),

    s({ trig = "TVV", snippetType = "autosnippet", condition = in_mathzone }, {
      t(" \\underset{"),
      i(1, "x"),
      t(" \\to "),
      i(2, "a"),
      t("}{\\longrightarrow} "),
      i(3, "L"),
      i(0)
    }),


    -- Petit o
    s({ trig = "PO", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\underset{"),
      i(1, "x"),
      t(" \\to "),
      i(2, "a"),
      t("}{o}\\left("),
      i(3),
      t("\\right) "),
      i(0),
    }),

    -- Équivalent
    s({ trig = "EQ", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\underset{"),
      i(1, "x"),
      t(" \\to "),
      i(2, "a"),
      t("}{\\sim} "),
      i(3),
      i(0),
    }),

    -- Grand O
    s({ trig = "GO", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\underset{"),
      i(1, "x"),
      t(" \\to "),
      i(2, "a"),
      t("}{O}\\left("),
      i(3),
      t("\\right) "),
      i(0),
    }),

    s({ trig = "ENT", snippetType = "autosnippet", condition = in_mathzone }, {
      t("[\\!["),
      i(1),
      t(", "),
      i(2),
      t("]\\!] "),
      i(0),
  }),



      -- Probabilités
    s({ trig = "PP", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\mathbf{P}\\left("),
      d(1, visual_or_empty),
      t("\\right) "),
      i(0),
    }),

    s({ trig = "EE", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\mathbf{E}\\left["),
      d(1, visual_or_empty),
      t("\\right] "),
      i(0),
    }),

    s({ trig = "VV", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\mathbf{V}\\left("),
      d(1, visual_or_empty),
      t("\\right) "),
      i(0),
    }),

    -- Ensemble en compréhension
    s({ trig = "SET", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\left\\{ "),
      i(1),
      t(" \\middle|\\ "),
      i(2),
      t(" \\right\\} "),
      i(0),
    }),

    -- Opérations ensemblistes
    s({ trig = "CAP", snippetType = "autosnippet", condition = in_mathzone }, { t("\\cap ") }),
    s({ trig = "CUP", snippetType = "autosnippet", condition = in_mathzone }, { t("\\cup ") }),
    s({ trig = "IN", snippetType = "autosnippet", condition = in_mathzone }, { t("\\in ") }),

    -- Algèbre linéaire
    s({ trig = "IM",  snippetType = "autosnippet", condition = in_mathzone }, { t("\\mathrm{Im}\\left("), d(1, visual_or_empty), t("\\right) "), i(0) }),
    s({ trig = "KER", snippetType = "autosnippet", condition = in_mathzone }, { t("\\mathrm{Ker}\\left("),        d(1, visual_or_empty), t("\\right) "), i(0) }),
    s({ trig = "DET", snippetType = "autosnippet", condition = in_mathzone }, { t("\\mathrm{det}\\left("),        d(1, visual_or_empty), t("\\right) "), i(0) }),
    s({ trig = "TR",  snippetType = "autosnippet", condition = in_mathzone }, { t("\\mathrm{tr}\\left("), d(1, visual_or_empty), t("\\right) "), i(0) }),


    s({ trig = "CIR", snippetType = "autosnippet", condition = in_mathzone }, { t("\\circ ") }),


    s({ trig = "VID", snippetType = "autosnippet", condition = in_mathzone }, { t("\\varnothing ") }),

    s({ trig = "DER", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\frac{\\mathrm{d}}{\\mathrm{d}"),
      i(1, "x"),
      t("} "),
      i(0),
    }),


    s({ trig = "PAR", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\frac{\\partial "),
      i(1),
      t("}{\\partial "),
      i(2, "x"),
      t("} "),
      i(0),
    }),

    s({ trig = "SSUP", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\sup_{"), i(1), t("} "), i(0),
    }),
    s({ trig = "IINF", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\inf_{"), i(1), t("} "), i(0),
    }),
    s({ trig = "MMAX", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\max_{"), i(1), t("} "), i(0),
    }),
    s({ trig = "MMIN", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\min_{"), i(1), t("} "), i(0),
    }),


    s({ trig = "ID", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\mathrm{Id}_{"),
      i(1),
      t("} "),
      i(0),
    }),

    s({ trig = "ZER", snippetType = "autosnippet", condition = in_mathzone }, {
      t("\\mathrm{0}_{"),
      i(1),
      t("} "),
      i(0),
    }),



    }




-- lettres grecques
for key, name in pairs(greek_letters) do
    -- Minuscules (ex: ;a -> \alpha)
    table.insert(snippets, s({ snippetType = "autosnippet", trig = ";" .. key, condition = in_mathzone }, { t("\\" .. name .. "") }))

    -- Majuscules (ex: ;A -> \Alpha ou \Gamma)
    -- On met la première lettre en majuscule pour le nom LaTeX
    -- local capitalized_name = name:gsub("^%l", string.upper)
    -- table.insert(snippets, s({ snippetType = "autosnippet", trig = ";" .. key:upper() }, { t("\\" .. capitalized_name .. "") }))
end



-- Délimiteurs tex usuels
local delimiters = {
    [";("]  = { "\\left( ",   " \\right)",   true  },
    ["(("]  = { "\\left( ",   " \\right)",   true  },
    [";["]  = { "\\left[ ",   " \\right]",   true  },
    [";{"]  = { "\\left\\{ ", " \\right\\}", true  },
    ["{{"]  = { "\\left\\{ ", " \\right\\}", true  },
    [";\""  ] = { "\\og ",    " \\fg{}",     false },
}

for trig, brackets in pairs(delimiters) do
    local cond = brackets[3] and in_mathzone or nil
    table.insert(snippets, s(
        { trig = trig, snippetType = "autosnippet", wordTrig = false, condition = cond },
        {
            t(brackets[1]),
            d(1, visual_or_empty),
            t(brackets[2] .. " "),
            i(0),
        }
    ))
end

-- Intervalles 
local interval_delimiters = {
    ["[["] = { "\\left[ ", " \\right[ " },
    -- ["]]"] = { "\\left] ", " \\right] " },
    ["[]"] = { "\\left[ ", " \\right] " },
    ["]["] = { "\\left] ", " \\right[ " },
}

for trig, brackets in pairs(interval_delimiters) do
    table.insert(snippets, s({ 
        trig = trig, 
	snippetType = "autosnippet", 
        -- On ajoute une priorité haute pour "passer devant" les autres mappings
	wordTrig = false,
        priority = 1000,
	condition = in_mathzone,

    }, {
        t(brackets[1]),
        i(1),
        t(brackets[2]),
        i(0)
    } ))
end



local delimiters_newline = {
    ["APA"] = { "\\begin{apart}", "\\end{apart}" },
    ["CEN"] = { "\\begin{center}", "\\end{center}" },
}


for trig, brackets in pairs(delimiters_newline) do
    table.insert(snippets, s(
        { trig = trig, snippetType = "autosnippet" },
        d(1, function(args, parent)
            local visual = parent.env.TM_SELECTED_TEXT or {}
            if #visual > 0 then
                -- Indente chaque ligne de la sélection
                local indented = {}
                for _, line in ipairs(visual) do
                    table.insert(indented, indent .. line)
                end
                return sn(nil, {
                    t({ brackets[1], "" }),
                    t(indented),
                    t({ "", brackets[2], "" }),
                    i(0),
                })
            else
                return sn(nil, {
                    t({ brackets[1], indent }),
                    i(1),
                    t({ "", brackets[2], "" }),
                    i(0),
                })
            end
        end)
    ))
end


-- ;$ en visuel à la vim-latex
table.insert(snippets, s(
    { trig = ";$", snippetType = "autosnippet", wordTrig = false  },
    {
        d(1, function(args, snip)
            local visual = snip.env.LS_SELECT_RAW
            local has_visual = visual and (#visual > 1 or (visual[1] and visual[1] ~= ""))
            local is_linewise = vim.fn.visualmode() == "V" or (visual and #visual > 1)

            local content = (has_visual and visual[1] ~= "") and visual or { "" }

            if has_visual and is_linewise then
                return sn(nil, {
                    t({ "\\[", indent }),
                    t(content),              -- t() au lieu de i() : pas de select mode
                    t({ "", "\\]" }),
                })
            else
                return sn(nil, {
                    t("$ "),
                    t(content),              -- idem
                    t(" $"),
                })
            end
        end),
        i(0),                                -- curseur ici directement, en insert mode
    }
))
return snippets


