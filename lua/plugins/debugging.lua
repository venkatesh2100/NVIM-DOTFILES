return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap-python",
      "mfussenegger/nvim-dap-vscode-js",
      "mfussenegger/nvim-jdtls",  -- For Java
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("dap-go").setup()
      require("nvim-dap-virtual-text").setup {
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      }

      -- Python setup
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

      -- JavaScript/TypeScript setup
      require("dap-vscode-js").setup({
        node_path = "node",  -- Path to the Node.js executable
        adapters = { "pwa-node" },  -- Debugging adapters for Node.js and web applications
        debugger_cmd = { "js-debug-adapter" },
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
      })

      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process",
            processId = require('dap.utils').pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end

      -- Java setup
      local jdtls = require('jdtls')
      dap.configurations.java = {
        {
          type = 'java',
          request = 'launch',
          name = "Debug (Launch) - Current File",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = 'java',
          request = 'attach',
          name = "Debug (Attach) - Remote",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }

      vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F13>", dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}

