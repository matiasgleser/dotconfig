-- MATI FIX FOR SEPARATE PYTHON AND LATEX FILES

-- local env_config = os.getenv("LVIM_CONFIG")
-- if env_config then
--   local config_path = string.format("%s/config.%s.lua", vim.fn.stdpath("config"), env_config)
--   if vim.fn.filereadable(config_path) == 1 then
--     print("Loading config file: " .. config_path) -- Add this line
--     require("config.lvim" .. env_config)
--     -- return -- Skip loading the rest of the default config
--   else
--     print("Config file not found: " .. config_path) -- Add this line to handle file not found
--   end

-- end
-- -- The rest of the init.lua content...

-- -- END MATI FIX


local base_dir = vim.env.LUNARVIM_BASE_DIR
  or (function()
    local init_path = debug.getinfo(1, "S").source
    return init_path:sub(2):match("(.*[/\\])"):sub(1, -2)
  end)()

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:prepend(base_dir)
end

require("lvim.bootstrap"):init(base_dir)

require("lvim.config"):load()

local plugins = require "lvim.plugins"

require("lvim.plugin-loader").load { plugins, lvim.plugins }

require("lvim.core.theme").setup()

local Log = require "lvim.core.log"
Log:debug "Starting LunarVim"

local commands = require "lvim.core.commands"
commands.load(commands.defaults)
