require'nightfox'.setup({
    options = {
        transparent = true,
        inverse = {
            match_paren = true
        }
    }
})

vim.cmd("colorscheme nightfox")

vim.api.nvim_set_hl(0, 'Pmenu', {bg = 'none'})
