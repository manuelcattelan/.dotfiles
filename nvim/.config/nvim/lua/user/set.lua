local sets = {
    guicursor = "",

    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,

    number = true,
    relativenumber = true,
    incsearch = true,
    hlsearch = false,

    smartindent = true,
    autoindent = true,

    ignorecase = true,
    smartcase = true,

    signcolumn = "auto",
    colorcolumn = "80",
    pumheight = 10,
    laststatus = 3,
    scrolloff = 20,

    mouse = "a",
    hidden = true,
    swapfile = false,
    wrap = false,
    splitbelow = true,
    splitright = true,
}

for k, v in pairs(sets) do
    vim.opt[k] = v
end

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25
