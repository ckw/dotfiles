vim.cmd([[

set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
source ~/.vimrc
au TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=250, on_visual=false }


let g:peekup_open = '<leader>r'
set completeopt=menu,menuone,noselect
]]
)

-- Over SSH, send yanks to the local terminal's clipboard with OSC 52 (not the
-- remote Mac's pbcopy). Paste from nvim's own register: reading the clipboard
-- over OSC 52 makes Ghostty prompt on every `p` (clipboard=unnamedplus).
if os.getenv("SSH_TTY") then
  local osc52 = require("vim.ui.clipboard.osc52")
  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end
  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.loader.enable()
--require 'plugins'
--
local lazy_plugins = {
  {'junegunn/fzf'},
  {'gennaro-tedesco/nvim-peekup'},
  {'jremmen/vim-ripgrep'},
  {'easymotion/vim-easymotion'},
  --, 'mason-lspconfig'
  --{ 'cmp'},
  --{ "L3MON4D3/LuaSnip",
  --	-- follow latest release.
  --	version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  --	-- install jsregexp (optional!).
  --	--build = "make install_jsregexp"
  --},
  {'junegunn/fzf.vim'},
  {'neovim/nvim-lspconfig'},
  --{'preservim/nerdtree'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-vsnip'},
  {'hrsh7th/vim-vsnip'},
  --{'hrsh7th/cmp-cmdline'},
  --{'saadparwaiz1/cmp_luasnip'},
  {'nvim-lua/plenary.nvim'},
  {'scalameta/nvim-metals', dependencies = { "nvim-lua/plenary.nvim" }},
  {
  --'nvim-telescope/telescope.nvim', tag = '0.1.8',
  'nvim-telescope/telescope.nvim',
   --or , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    defaults = { debug = true },
  },
--'mhanberg/elixir.nvim'
--'elixir-editors/vim-elixir'

--'tikhomirov/vim-glsl'
  --{
  --  "tidalcycles/vim-tidal",
  --  ft = "tidal",
  --  init = function()
  --    --vim.g.tidal_no_mappings = 1
  --    vim.g.maplocalleader = " "                    -- so <localleader>s works
  --    vim.g.tidal_target   = "terminal"              -- use nvim terminal
  --    vim.g.tidal_ghci     = "stack exec ghci --"    -- use Stack’s ghci
  --    vim.g.tidal_boot     = "/Users/ckw/tidal-live/BootTidal.hs" -- your working Boot (new-style)
  --  end,
  --  config = function()
  --    -- buffer-local keymaps for tidal files
  --    --vim.keymap.set("n","<localleader>d","<Plug>TidalSendLine",{buffer=true})
  --    --vim.keymap.set("v","<localleader>s","<Plug>TidalSend",   {buffer=true})
  --    --vim.keymap.set("n","<localleader>a","<Plug>TidalHush",   {buffer=true})
  --  end
  --}
  {
    --dir = "/Users/ckw/mru-buffer-picker",
    "ckw/mru-buffer-picker",
    opts = {
      --keys = "asdfghjkl;",
      keys = "asdfjkl;eirughwptyo",
    },
    keys = {
      {
        "<leader><leader>",
        function()
          require("mru_buffer_picker").open()
        end,
      },
    },
  }
}

require("lazy").setup(lazy_plugins)

--vim.api.nvim_set_hl(0, "MruBufferPickerHint", {
--  bg = "#ffffff",
--  fg = "#ff0000",
--  bold = true,
--})


local cmp = require('cmp')
--local luasnip = require('luasnip')
--
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),

    ["<C-e>"] = cmp.mapping.abort(),

    ["<C-l>"] = cmp.mapping.confirm({
      select = true,
    }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            "<Plug>(vsnip-expand-or-jump)",
            true,
            true,
            true
          ),
          ""
        )
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            "<Plug>(vsnip-jump-prev)",
            true,
            true,
            true
          ),
          ""
        )
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "buffer" },
  }),
})
