return {
	{
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>fr',  ":Telescope oldfiles<CR>", {})
    end
},

{ 
	'akinsho/toggleterm.nvim', 
	version = "*", 
	config = function()
		require("toggleterm").setup{
			insert_mappings = true, -- whether or not the open mapping applies in insert mode
			open_mapping = [[<leader>tt]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
			direction = "float",
			float_opts = { border = 'curved'}
		}
	end

},
{
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	opts = { on_attach = on_attach_change },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {
			vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" }),
			vim.keymap.set("n", "<leader>ft", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })


		}
	end,
},

{
	'romgrk/barbar.nvim',
	dependencies = {
		'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
		'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
	},
	init = function() vim.g.barbar_auto_setup = false end,
	opts = {

	},
	version = '^1.0.0', -- optional: only update when a new 1.x version is released
},

}


