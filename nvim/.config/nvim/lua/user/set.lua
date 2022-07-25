local sets = {
    guicursor = "",
    cursorline = true,

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
    scrolloff = 10,
    sidescrolloff = 10,

    mouse = "a",
    hidden = true,
    swapfile = false,
    wrap = false,
}

for k, v in pairs(sets) do
    vim.opt[k] = v
end
