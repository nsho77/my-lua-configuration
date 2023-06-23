local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local cmp = require'cmp'
cmp.setup({ 
    -- Required by vsnip
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },

    mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        ['<C-z>'] = cmp.mapping(cmp.mapping.complete(),{"i", "c"}),
        ['<C-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ['<CR>'] = cmp.mapping.confirm {
            select = true,
        }
    },

    -- sources are the installed sources that can be used for code suggestions
    sources = {
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'vsnip', keyword_length = 2 },
        { name = 'nvim_lua', keyword_length = 2},
        { name = 'nvim_lsp_signature_help'}, 
        { name = 'buffer', keyword_length = 2 },
        { name = 'path' },
    },

    -- Add borders to the windows
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    -- add formating of the different sources
    formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
            local menu_icon ={
                nvim_lsp = 'λ',
                vsnip = '⋗',
                buffer = 'b',
                path = 'p',
                nvim_lua = 'lu',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
})
