local function load_env_file()
  local env = {}
  local path = vim.fn.getcwd() .. "/.env"
  local f = io.open(path, "r")
  if not f then
    return env
  end
  for line in f:lines() do
    if not line:match("^#") and not line:match("^%s*$") and line:match("=") then
      local key, val = line:match("^([^=]+)=(.*)")
      if key and val then
        env[vim.trim(key)] = vim.trim(val)
      end
    end
  end
  f:close()
  return env
end

local function make_env(port)
  local dotenv = load_env_file()
  local env = {
    ASPNETCORE_ENVIRONMENT = "Development",
    ASPNETCORE_URLS = "http://localhost:" .. port,
  }
  local key_map = {
    ENCRYPTION_KEY = "Encryption__Key",
    ENCRYPTION_IV = "Encryption__IV",
    ENCRYPTION_CONN_KEY = "Encryption__ConnectionStringKey",
    ENCRYPTION_CONN_IV = "Encryption__ConnectionStringIV",
  }
  for dotenv_key, aspnet_key in pairs(key_map) do
    if dotenv[dotenv_key] then
      env[aspnet_key] = dotenv[dotenv_key]
    end
  end
  return env
end

return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.exepath("netcoredbg"),
        args = { "--interpreter=vscode" },
      }

      dap.defaults.coreclr.exception_breakpoints = { "uncaught" }

      local root = vim.fn.getcwd()

      dap.configurations.cs = {
        {
          name = "Launch Infrastructure Manager",
          type = "coreclr",
          request = "launch",
          program = root .. "/apps/infrastructure-manager/bin/Debug/net8.0/CompanySuite.InfrastructureManager.dll",
          cwd = root .. "/apps/infrastructure-manager",
          justMyCode = true,
          env = make_env("5301"),
        },
        {
          name = "Launch HRIS API",
          type = "coreclr",
          request = "launch",
          program = root .. "/apps/hris-api/bin/Debug/net8.0/CompanySuite.HrisApi.dll",
          cwd = root .. "/apps/hris-api",
          justMyCode = true,
          env = make_env("5101"),
        },
        {
          name = "Launch Tenant Portal API",
          type = "coreclr",
          request = "launch",
          program = root .. "/apps/tenant-portal-api/bin/Debug/net8.0/CompanySuite.TenantPortalApi.dll",
          cwd = root .. "/apps/tenant-portal-api",
          justMyCode = true,
          env = make_env("5001"),
        },
        {
          name = "Launch Applicant Portal API",
          type = "coreclr",
          request = "launch",
          program = root .. "/apps/applicant-portal-api/bin/Debug/net8.0/CompanySuite.ApplicantPortalApi.dll",
          cwd = root .. "/apps/applicant-portal-api",
          justMyCode = true,
          env = make_env("5201"),
        },
        {
          name = "Launch Mailer API",
          type = "coreclr",
          request = "launch",
          program = root .. "/apps/mailer-api/bin/Debug/net8.0/CompanySuite.MailerApi.dll",
          cwd = root .. "/apps/mailer-api",
          justMyCode = true,
          env = make_env("5010"),
        },
        {
          name = "Attach to .NET Process",
          type = "coreclr",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
      }

      -- Prevent launch.json from being loaded (avoids duplicate configs)
      require("dap.ext.vscode").load_launchjs = function() end
    end,
  },
}
