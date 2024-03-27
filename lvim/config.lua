local env_config = os.getenv("LVIM_CONFIG")

if env_config then
  local mod = "user." .. env_config

  require(mod)
end
