local function define_colors()
  -- vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#b91c1c' })
  -- vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef' })
  -- vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bold = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      desc = "prevent colorscheme clears self-defined DAP icon colors.",
      callback = function()
      	vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#FF1A23' })
      	vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef' })
      	vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#9BFF7E' })
      	vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { ctermbg = 0, fg = '#A5A6A8' })
      end
  })

  vim.fn.sign_define('DapBreakpoint', {
    text = '',
    numhl = 'DapBreakpoint',
    texthl = 'DapBreakpoint',
  })
  vim.fn.sign_define('DapBreakpointCondition', {
    text = '',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint',
    texthl = 'DapBreakpoint',
  })
  vim.fn.sign_define('DapBreakpointRejected', {
    text = '',
    linehl = 'DapBreakpointRejected',
    numhl = 'DapBreakpointRejected',
    texthl = 'DapBreakpointRejected',
  })
  vim.fn.sign_define('DapStopped', {
    text = '󰜴',
    linehl = 'DapStopped',
    numhl = 'DapStopped',
    texthl = 'DapStopped',
  })
  vim.fn.sign_define('DapLogPoint', {
    text = '🟣',
    linehl = 'DapLogPoint',
    numhl = 'DapLogPoint',
  })
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'Joakker/lua-json5',
    },
    config = function()
      local dap = require 'dap'
      define_colors()

      -- launch.json files can have comments etc, so we need json5
      require('dap.ext.vscode').json_decode = require'json5'.parse

      vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = '[D]AP [T]erminate' })
      vim.keymap.set('n', '<leader>dr', dap.restart, { desc = '[D]AP [R]estart' })
      vim.keymap.set('n', '<leader>dn', ':DapNew<CR>', { desc = '[D]AP [N]ew' })
      vim.keymap.set('n', '<F6>', ':DapStepOver<CR>', { desc = '[D]AP [S]tep [O]ver' })
      vim.keymap.set('n', '<F7>', ':DapStepInto<CR>', { desc = '[D]AP [S]tep [I]nto' })
      vim.keymap.set('n', '<F8>', ':DapStepOut<CR>', { desc = '[D]AP [S]tep O[u]t' })
      vim.keymap.set('n', '<F5>', ':DapContinue<CR>', { desc = '[D]AP [C]ontinue' })
      vim.keymap.set('n', '<leader>b', ':DapToggleBreakpoint<CR>', { desc = '[D]AP Toggle [B]reakpoint' })
      vim.keymap.set('n', '<leader>dB', ':DapClearBreakpoints<CR>', { desc = '[D]AP Clear [B]reakpoints' })
      vim.keymap.set('n', '<space>?', function()
          require('dapui').eval(nil, { enter = true })
      end)


      dap.adapters.codelldb = {
        type = 'executable',
        command = 'codelldb',

        -- On windows you may have to uncomment this:
        -- detached = false,
      }

     --  dap.adapters.codelldb = {
     --   type = 'server',
     --   port = '${port}',
     --   executable = {
     --     command = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb',
     --     args = { '--port', '${port}' },
     --   },
     -- }
      dap.adapters.lldb = {
        type = 'executable',
        command = 'codelldb',

        -- On windows you may have to uncomment this:
        -- detached = false,
      }
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      dapui.setup {
	layouts = {
	    {
              elements = {
                { id = 'scopes', size = 0.25 },
                { id = 'breakpoints', size = 0.25 },
                { id = 'stacks', size = 0.25 },
                { id = 'watches', size = 0.25 },
              },
              position = 'left',
              size = 60,
            },
            {
              elements = {
                { id = 'repl', size = 0.25 },
                { id = 'console', size = 0.75 },
              },
              position = 'bottom',
              size = 30,
            },
	},
	mappings = {
      	  expand = { '<CR>', '<2-LeftMouse>' },
      	  open = 'o',
      	  remove = 'd',
      	  edit = 's',
      	  repl = 'r',
      	  toggle = 't',
      	},
    }

      vim.keymap.set('n', '<leader>td', dapui.toggle, { desc = '[T]oggle [D]AP' })

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'mason-org/mason.nvim', 'mfussenegger/nvim-dap' },
    config = function()
      require('mason-nvim-dap').setup {
        automatic_installation = true,
        ensure_installed = {},
      }
    end,
  },
  {
    'lucaSartore/nvim-dap-exception-breakpoints',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      local set_exception_breakpoints = require 'nvim-dap-exception-breakpoints'
      vim.keymap.set('n', '<leader>de', set_exception_breakpoints, { desc = '[D]AP [E]xceptions' })
    end,
  },
}
