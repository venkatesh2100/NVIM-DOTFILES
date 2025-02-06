return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- UI for debugging
      "theHamsta/nvim-dap-virtual-text", -- Inline debug info
      "nvim-neotest/nvim-nio", -- Required for nvim-dap-ui
      "williamboman/mason.nvim", -- Manage debuggers
      "mfussenegger/nvim-dap-python", -- Python debugging
      "mfussenegger/nvim-dap-vscode-js", -- JavaScript/TypeScript debugging
      "mfussenegger/nvim-jdtls", -- Java debugging
      "leoluz/nvim-dap-go", -- Go debugging
    },
    event = "VeryLazy", -- Lazy load for faster startup
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- 🔹 Setup UI Components
      dapui.setup()
      require("nvim-dap-virtual-text").setup({
        display_callback = function(variable)
          local name, value = string.lower(variable.name), string.lower(variable.value)
          if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
            return "*****"
          elseif #variable.value > 20 then
            return " " .. string.sub(variable.value, 1, 20) .. "... "
          end
          return " " .. variable.value
        end,
      })

      -- 🔹 Debugging UI Auto Open/Close
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- 🔹 Python Setup
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

      -- 🔹 JavaScript & TypeScript Setup
      require("dap-vscode-js").setup({
        node_path = "node",
        adapters = { "pwa-node" },
        debugger_cmd = { "js-debug-adapter" },
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
      })

      for _, lang in ipairs({ "typescript", "javascript" }) do
        dap.configurations[lang] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch File",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end

      -- 🔹 Java Setup
      dap.configurations.java = {
        {
          type = "java",
          request = "launch",
          name = "Debug (Launch) - Current File",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "java",
          request = "attach",
          name = "Debug (Attach) - Remote",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }

      -- 🔹 Go Setup
      require("dap-go").setup()

      -- 🔹 Keybindings for Debugging
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue Debugging" })
      vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart Debugging" })
      vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Stop Debugging" })
      vim.keymap.set("n", "<leader>de", function()
        dapui.eval(nil, { enter = true })
      end, { desc = "Evaluate Variable" })
    end,
  },
}
