local dap = require('dap')

-- netcoredbg adapter configuration
dap.adapters.coreclr = {
  type = 'executable',
  command = 'netcoredbg',
  args = {'--interpreter=vscode'}
}

-- C# config
dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}
