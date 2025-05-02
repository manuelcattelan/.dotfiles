return {
  "mfussenegger/nvim-dap",
  dependencies = { "nvim-neotest/nvim-nio", "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text" },
  config = function()
    local dap = require("dap")
    local dap_ui = require("dapui")
    local dap_virtual_text = require("nvim-dap-virtual-text")
    dap_ui.setup()
    ---@diagnostic disable-next-line: missing-parameter
    dap_virtual_text.setup()
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>dc", dap.continue)
    vim.keymap.set("n", "<leader>dC", dap.run_to_cursor)
    vim.keymap.set("n", "<leader>di", dap.step_into)
    vim.keymap.set("n", "<leader>do", dap.step_out)
    vim.keymap.set("n", "<leader>dO", dap.step_over)
    vim.keymap.set("n", "<leader>dC", dap.run_to_cursor)
    vim.keymap.set("n", "<leader>dr", dap.restart)
    vim.keymap.set("n", "<leader>dt", dap.terminate)
    vim.keymap.set("n", "<leader>dh", function()
      require("dap.ui.widgets").hover()
    end)
    dap.listeners.before.attach.dapui_config = function()
      dap_ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dap_ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dap_ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dap_ui.close()
    end
    local vscode = require("dap.ext.vscode")
    local json = require("plenary.json")
    ---@diagnostic disable-next-line: duplicate-set-field
    vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str))
    end
  end,
}
