# Key bindings

        keymap("n", "<leader>dcc", dap.continue, { desc = "Debug: Continue" })
        keymap("n", "<leader>dso", dap.step_over, { desc = "Debug: Step Over" })
        keymap("n", "<leader>dsi", dap.step_into, { desc = "Debug: Step Into" })
        keymap("n", "<leader>dsu", dap.step_out, { desc = "Debug: Step Out" })
        keymap("n", "<leader>dbb", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
        keymap("n", "<leader>drr", dap.repl.open, { desc = "Debug: Open REPL" })
        keymap("n", "<leader>duu", dapui.toggle, { desc = "Debug: Toggle UI" })
        keymap("n", "<leader>dtt", dap.terminate, { desc = "Debug: Terminate" })
