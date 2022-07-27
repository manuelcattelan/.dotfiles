require'nightfox'.setup({
    options = {
        transparent = true,
        inverse = {
            match_paren = true
        }
    },
    palettes = {
        nightfox = {
            bg0 = 'none'
        }
    }
})


vim.cmd("colorscheme nightfox")

vim.api.nvim_set_hl(0, 'Pmenu', {bg = 'none'})
