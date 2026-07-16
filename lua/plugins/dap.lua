return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			-- Optional but recommended
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local virtual_text = require("nvim-dap-virtual-text")

			-- Setup DAP UI
			dapui.setup()

			-- Virtual text (shows variable values inline)
			virtual_text.setup()

			-- Auto open/close UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Keymaps
			local keymap = vim.keymap.set
			keymap("n", "<leader>dcc", dap.continue, { desc = "Debug: Continue" })
			keymap("n", "<leader>dso", dap.step_over, { desc = "Debug: Step Over" })
			keymap("n", "<leader>dsi", dap.step_into, { desc = "Debug: Step Into" })
			keymap("n", "<leader>dsu", dap.step_out, { desc = "Debug: Step Out" })
			keymap("n", "<leader>dbb", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			keymap("n", "<leader>drr", dap.repl.open, { desc = "Debug: Open REPL" })
			keymap("n", "<leader>duu", dapui.toggle, { desc = "Debug: Toggle UI" })
			keymap("n", "<leader>dtt", dap.terminate, { desc = "Debug: Terminate" })

			-- Mason DAP auto setup
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb" },
				handlers = {},
			})

			-- ====================== Rust Configuration ======================
			local mason_registry = require("mason-registry")
			local codelldb_pkg = mason_registry.get_package("codelldb")
			local codelldb_path = codelldb_pkg:get_install_path() .. "/extension/adapter/codelldb"

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb_path,
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					name = "Launch (Rust)",
					type = "codelldb",
					request = "launch",
					program = function()
						-- You can customize this (e.g. always use target/debug/<project>)
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					runInTerminal = false,
				},
				{
					name = "Debug Tests (Rust)",
					type = "codelldb",
					request = "launch",
					program = function()
						-- This runs cargo test --no-run and lets you choose which test binary
						print("Building test binaries...")
						vim.fn.system("cargo test --no-run --quiet")

						local test_binaries = vim.fn.glob("target/debug/deps/*", false, true)

						if #test_binaries == 0 then
							return vim.fn.input(
								"No test binary found. Enter path: ",
								vim.fn.getcwd() .. "/target/debug/deps/",
								"file"
							)
						end

						-- Let you choose from a nicer list
						local choice = vim.fn.inputlist(vim.tbl_map(function(bin)
							return vim.fn.fnamemodify(bin, ":t") -- show only filename
						end, test_binaries))

						if choice > 0 and choice <= #test_binaries then
							return test_binaries[choice]
						else
							return test_binaries[1] -- fallback to first one
						end
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = true,
				},
			}

			-- Optional: Better Rust test debugging with rustaceanvim (if you use it)
			-- vim.g.rustaceanvim = { ... } in your rust config
		end,
	},
}
