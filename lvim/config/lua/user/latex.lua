-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny


-- Added start.lua config for LaTeX

lvim.format_on_save = false
-- lvim.lsp.diagnostics.virtual_text = true
-- lvim.diagnostics.virtual_text = true

lvim.builtin.treesitter.highlight.enable = true

-- Auto install treesitter parsers.
lvim.builtin.treesitter.ensure_installed = { "latex" }

-- Setup Lsp.
local capabilities = require("lvim.lsp").common_capabilities()
require("lvim.lsp.manager").setup("texlab", {
  on_attach = require("lvim.lsp").common_on_attach,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = capabilities,
})

-- Setup formatters.
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "latexindent", filetypes = { "tex" } },
})

-- Set a linter.
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { command = "chktex", filetypes = { "tex" } },
})

-- UltiSnip configuration.
vim.cmd([[
  let g:UltiSnipsExpandTrigger="<CR>"
  let g:UltiSnipsJumpForwardTrigger="<Plug>(ultisnips_jump_forward)"
  let g:UltiSnipsJumpBackwardTrigger="<Plug>(ultisnips_jump_backward)"
  let g:UltiSnipsListSnippets="<c-x><c-s>"
  let g:UltiSnipsRemoveSelectModeMappings=0
  let g:UltiSnipsEditSplit="tabdo"
  let g:UltiSnipsSnippetDirectories=[$HOME."/.config/nvim/UltiSnips"]
]])

-- Vimtex configuration.
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_enabled = 0

-- MATI CONFIG FOR CONTINUOUS COMPILING

vim.g.vimtex_compiler_latexmk = {
    continuous = 1
}

-- Autocommand to compile on save
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.tex",
    command = "VimtexCompile"
})


function ClearLatexAuxFiles()
  -- Define the directory where your LaTeX files are located
  -- For this example, we use the current working directory
  local latex_dir = vim.fn.getcwd()
  
  -- Define the pattern for files you want to delete
  -- Adjust this pattern to include any other file extensions you need to clear
  local pattern = "*.aux *.log *.out *.toc"

  -- Construct the shell command
  -- This command navigates to the LaTeX directory and removes the specified files
  local command = "cd " .. latex_dir .. " && rm -f " .. pattern

  -- Execute the command
  vim.fn.system(command)

  -- Optionally, print a message to confirm the action
  print("Cleared LaTeX auxiliary files in " .. latex_dir)
end

-- vim.cmd("command! ClearLatexAuxFiles lua ClearLatexAuxFiles()")


-- New command for automatic cleanup
vim.api.nvim_create_autocmd("User", {
    pattern = "VimtexEventQuit",
    callback = ClearLatexAuxFiles
    -- callback = function()
        -- vim.cmd("LatexClean")
    -- end,
})



-- END MATI CONFIG

-- Setup cmp.
-- vim.api.nvim_create_autocmd("FileType", {
  -- group = vim.api.nvim_create_augroup("LaTeXGroup", { clear = true }),
  -- pattern = "tex",
  -- callback = function()
    -- require("user.cmp")
  -- end,
-- })


-- Mappings
lvim.builtin.which_key.mappings["C"] = {
  name = "LaTeX",
  m = { "<cmd>VimtexContextMenu<CR>", "Open Context Menu" },
  u = { "<cmd>VimtexCountLetters<CR>", "Count Letters" },
  w = { "<cmd>VimtexCountWords<CR>", "Count Words" },
  d = { "<cmd>VimtexDocPackage<CR>", "Open Doc for package" },
  e = { "<cmd>VimtexErrors<CR>", "Look at the errors" },
  s = { "<cmd>VimtexStatus<CR>", "Look at the status" },
  a = { "<cmd>VimtexToggleMain<CR>", "Toggle Main" },
  v = { "<cmd>VimtexView<CR>", "View pdf" },
  i = { "<cmd>VimtexInfo<CR>", "Vimtex Info" },
  l = {
    name = "Clean",
    l = { "<cmd>VimtexClean<CR>", "Clean Project" },
    c = { "<cmd>VimtexClean<CR>", "Clean Cache" },
  },
  c = {
    name = "Compile",
    c = { "<cmd>VimtexCompile<CR>", "Compile Project" },
    o = {
      "<cmd>VimtexCompileOutput<CR>",
      "Compile Project and Show Output",
    },
    s = { "<cmd>VimtexCompileSS<CR>", "Compile project super fast" },
    e = { "<cmd>VimtexCompileSelected<CR>", "Compile Selected" },
  },
  r = {
    name = "Reload",
    r = { "<cmd>VimtexReload<CR>", "Reload" },
    s = { "<cmd>VimtexReloadState<CR>", "Reload State" },
  },
  o = {
    name = "Stop",
    p = { "<cmd>VimtexStop<CR>", "Stop" },
    a = { "<cmd>VimtexStopAll<CR>", "Stop All" },
  },
  t = {
    name = "TOC",
    o = { "<cmd>VimtexTocOpen<CR>", "Open TOC" },
    t = { "<cmd>VimtexTocToggle<CR>", "Toggle TOC" },
  },
}

lvim.plugins = {
  "lervag/vimtex",
  "kdheepak/cmp-latex-symbols",
  "KeitaNakamura/tex-conceal.vim",
  "SirVer/ultisnips",
}
