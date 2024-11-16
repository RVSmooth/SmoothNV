return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		config = function()
	require("telescope").setup({
		pickers = {

			find_files = {

				hidden = true,
			},
		},
	})

	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
	vim.keymap.set("n", "<C-p>", builtin.git_files, {})
	vim.keymap.set("n", "<leader>pws", function()
		local word = vim.fn.expand("<cword>")
		builtin.grep_string({ search = word })
	end)
	vim.keymap.set("n", "<leader>pWs", function()
		local word = vim.fn.expand("<cWORD>")
		builtin.grep_string({ search = word })
	end)
	vim.keymap.set("n", "<leader>ps", function()
		builtin.grep_string({ search = vim.fn.input("Grep > ") })
	end)
	vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
	vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", {})
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
	require("toggleterm").setup({
		insert_mappings = false, -- whether or not the open mapping applies in insert mode
		open_mapping = [[<leader>tt]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
		direction = "float",
		float_opts = { border = "curved" },
	})
		end,
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
	require("nvim-tree").setup({
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "nvimtree toggle window" }),
		vim.keymap.set("n", "<leader>ft", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" }),
	})
		end,
	},

	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
	vim.g.barbar_auto_setup = false
		end,
		opts = {
			auto_hide = true,
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
	local harpoon = require("harpoon")

	-- REQUIRED
	harpoon:setup()
	-- REQUIRED

	vim.keymap.set("n", "<leader>a", function()
		harpoon:list():add()
	end)
	vim.keymap.set("n", "<C-e>", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end)

	vim.keymap.set("n", "<C-h>", function()
		harpoon:list():select(1)
	end)
	vim.keymap.set("n", "<C-t>", function()
		harpoon:list():select(2)
	end)
	vim.keymap.set("n", "<C-n>", function()
		harpoon:list():select(3)
	end)
	vim.keymap.set("n", "<C-s>", function()
		harpoon:list():select(4)
	end)

	-- Toggle previous & next buffers stored within Harpoon list
	vim.keymap.set("n", "<C-S-P>", function()
		harpoon:list():prev()
	end)
	vim.keymap.set("n", "<C-S-N>", function()
		harpoon:list():next()
	end)
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
	local lint = require("lint")

	lint.linters_by_ft = {
		javascript = { "eslint_d" },
		typescript = { "eslint_d" },
		javascriptreact = { "eslint_d" },
		typescriptreact = { "eslint_d" },
		svelte = { "eslint_d" },
		kotlin = { "ktlint" },
		terraform = { "tflint" },
		ruby = { "standardrb" },
	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			lint.try_lint()
		end,
	})

	vim.keymap.set("n", "<leader>ll", function()
		lint.try_lint()
	end, { desc = "Trigger linting for current file" })
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			svelte = { { "prettierd", "prettier", stop_after_first = true } },
			astro = { { "prettierd", "prettier", stop_after_first = true } },
			javascript = { { "prettierd", "prettier", stop_after_first = true } },
			typescript = { { "prettierd", "prettier", stop_after_first = true } },
			javascriptreact = { { "prettierd", "prettier", stop_after_first = true } },
			typescriptreact = { { "prettierd", "prettier", stop_after_first = true } },
			json = { { "prettierd", "prettier", stop_after_first = true } },
			graphql = { { "prettierd", "prettier", stop_after_first = true } },
			java = { "google-java-format" },
			kotlin = { "ktlint" },
			ruby = { "standardrb" },
			markdown = { { "prettierd", "prettier", stop_after_first = true } },
			erb = { "htmlbeautifier" },
			html = { "htmlbeautifier" },
			bash = { "beautysh" },
			proto = { "buf" },
			rust = { "rustfmt" },
			yaml = { "yamlfix" },
			toml = { "taplo" },
			css = { { "prettierd", "prettier", stop_after_first = true } },
			scss = { { "prettierd", "prettier", stop_after_first = true } },
			sh = { "shellcheck" },
			go = { "gofmt" },
			python = { "isort", "black" },
		},
	})

	vim.keymap.set({ "n", "v" }, "<leader>l", function()
		conform.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		})
	end, { desc = "Format file or range (in visual mode)" })
		end,
	},
	{
		"ngtuonghy/live-server-nvim",
		event = "VeryLazy",
		build = ":LiveServerInstall",
		config = function()
	require("live-server-nvim").setup({
		custom = {
			"--port=8080",
			"--no-css-inject",
		},
		serverPath = vim.fn.stdpath("data") .. "/live-server/", --default
		open = "folder", -- folder|cwd     --default
	})
	vim.keymap.set({ "n", "v" }, "<leader>ls", ":LiveServerToggle<CR>")
		end,
	},
}
