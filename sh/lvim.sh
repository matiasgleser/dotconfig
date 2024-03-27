# Lua Configs
alias luamake="/opt/lua-language-server/3rd/luamake/luamake"

# Append /opt/lua-language-server/bin to the PATH
export PATH="$PATH:/opt/lua-language-server/bin"

# Add Support for LunarVim
export PATH=/home/mati/.local/bin:$PATH

export PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH


# Adds support for language specific LunarVim

alias texvim='LVIM_CONFIG=latex lvim'
alias pyvim='LVIM_CONFIG=python lvim'
