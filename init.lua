-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim
require("lazy").setup({
    'nburns/bbedit-vim-colors',
    {
        'tyru/open-browser-github.vim',
        dependency = { 'tyru/open-browser.vim' },
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signcolumn = true,
            watch_gitdir = { interval = 1000 },
        }
    },
    "ap/vim-css-color",
    {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter", -- Only load when you start typing
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<Tab>", -- Use Tab to accept suggestions
            next = "<M-]>",  -- Alt + ] for next suggestion
            prev = "<M-[>",  -- Alt + [ for prev suggestion
          },
        },
        panel = { enabled = true }, -- You can enable this later if you want a side panel
      })
    end,
  },
{
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      window = {
        layout = 'vertical', -- This creates the sidebar
        width = 0.4,         -- 40% of the screen
        relative = 'editor',
        side = 'right',
      },
      show_help = true,
    },
    keys = {
      -- Toggle the chat sidebar
      { "<D-S-c>", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle", mode = {"n", "i", "v"} },
    },
  },
})

vim.opt.background = "light"
vim.cmd.colorscheme("bbedit")

-- General Settings
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.backspace = { "eol", "start", "indent" }
vim.opt.backup = false
vim.opt.clipboard = "unnamed" -- Use system clipboard
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "81"
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.fileformat = "unix"
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.foldenable = false
vim.opt.hidden = true -- Allow switching buffers without saving
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.linebreak = true
vim.opt.linespace = 2
vim.opt.magic = true
vim.opt.modeline = true
vim.opt.modelines = 2
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.ruler = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.spell = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.tags = "tags;/"
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.timeoutlen = 1500
vim.opt.visualbell = false
vim.opt.whichwrap:append("<,>,h,l")
vim.opt.wrap = false
vim.opt.writebackup = false

-- Special Highlight for ColorColumn
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "lightgrey", ctermbg = "lightgrey" })

-- Disable visual bell (the Lua way)
vim.opt.visualbell = false
vim.opt.errorbells = false

local abbreviations = {
    WQ = 'wq',
    Wq = 'wq',
    wQ = 'wq',
    W  = 'w',
    Q  = 'q',
    ['Q!'] = 'q!',
}

for typo, correct in pairs(abbreviations) do
    vim.keymap.set('ca', typo, correct)
end

-- macos/emacs movement
vim.keymap.set({'c', 'i', 'n'}, '<C-a>', '<Home>')
vim.keymap.set({'c', 'i', 'n'}, '<C-e>', '<End>')
vim.keymap.set('i', '<M-BS>', '<C-W>', { noremap = true, silent = true })

-- Disable auto-commenting new lines
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end,
})

if vim.g.neovide then
    vim.o.guifont = "DejaVu Sans Mono:h14"
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_vfx_mode = ""
    vim.g.neovide_scroll_animation_length = 0.05
    vim.g.neovide_cursor_scroll_acceleration = 1.0

    -- Use system clipboard for copy/paste operations
    vim.g.neovide_input_use_substitutions = true
    vim.opt.clipboard = "unnamedplus"
    vim.keymap.set({'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't'}, '<D-v>', function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end, { noremap = true, silent = true })
    vim.keymap.set('n', '<D-s>', ':w<CR>')        -- Cmd+s to Save
    vim.keymap.set('v', '<D-c>', '"+y')            -- Cmd+c to Copy in Visual mode
    vim.keymap.set('n', '<D-v>', '"+p')            -- Cmd+v to Paste in Normal mode
    vim.keymap.set('i', '<D-v>', '<C-G>u<C-R><C-O>+', { noremap = true, silent = true }) -- Cmd+v to Paste in Insert mode
    vim.keymap.set('n', '<D-z>', 'u')              -- Cmd+z to Undo
    vim.keymap.set('n', '<D-a>', 'ggVG')           -- Cmd+a to Select All

    -- Cmd+w to Close Buffer
    vim.keymap.set('n', '<D-w>', ':q<CR>', { noremap = true, silent = true })
    vim.keymap.set({'i', 'v'}, '<D-w>', '<Esc>:q<CR>', { noremap = true, silent = true })

    -- Cmd+s to Save and stay in insert mode
    vim.keymap.set('i', '<D-s>', '<Esc>:w<CR>i', { noremap = true, silent = true })
end
	


vim.api.nvim_create_autocmd("FileType", {
  pattern = "copilot-chat",
  callback = function()
    -- Map Cmd+S to send the prompt in the chat buffer
    -- 'n' for normal mode, 'i' for insert mode
    vim.keymap.set({"n", "i"}, "<D-s>", function()
      require("CopilotChat").select_prompt()
    end, { buffer = true, remap = false })
  end,
})
vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)', { silent = true })
vim.keymap.set('i', '<M-[>', '<Plug>(copilot-prev)', { silent = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.opt.signcolumn = "yes"
