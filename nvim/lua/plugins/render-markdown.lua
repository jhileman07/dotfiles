return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        -- Sets the style of the markdown rendering
        heading = {
            -- Symbols for # through ######
            icons = { '◉ ', '○ ', '✸ ', '✿ ', '◈ ', '◇ ' },
            -- Background highlights for headers
            backgrounds = {
                'DiffAdd',
                'DiffChange',
                'DiffDelete',
                'DiffText',
            },
        },
        code = {
            -- Language icons in code blocks
            sign = true,
            width = 'block',
            right_pad = 1,
        },
        checkbox = {
            enabled = true,
            unchecked = { icon = '󰄱 ' },
            checked = { icon = ' ' },
        },
        pipe_table = {
            preset = 'round',
        },
        -- Important for your Compiler Notes:
        -- This enables LaTeX rendering for math formulas
        latex = {
            enabled = true,
            top_pad = 0,
            bottom_pad = 0,
        },
    },
}
