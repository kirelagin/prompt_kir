local prompt_distro_fg=${DISTRO_COLOUR:-green}
local prompt_host_fg=${HOST_COLOUR:-cyan}
local prompt_root_red=196
local prompt_line_fg="%(!.$prompt_root_red.15)"

local prompt_head_start="."
local prompt_line="-"
local prompt_branch="|"
local prompt_arrow_start="\`"
local prompt_arrow_user=">"
local prompt_arrow_root="%F{white}%K{$prompt_root_red}#%k%f"
local prompt_dots="..."

prompt_enable_utf8() {
  prompt_head_start="┌"
  prompt_line="─"
  prompt_branch="├"
  prompt_arrow_start="└"
  prompt_arrow_user="›"
  prompt_dots="…"
}


prompt_start_input_line() {
  echo "%F{$prompt_line_fg}${prompt_arrow_start}${prompt_line}%f"
}

prompt_branch_prev_line() {
  # Not sure about this one, there are some extra quotes in adam2 for some reason
  echo "%{\e[A\r%}%F{$prompt_line_fg}$prompt_branch%f%{\e[B\r%}"
}


prompt_ps1_line1() {
  local left_raw="%~"
  local left_width=${#${(S%%)left_raw//(\%([KF1]|)\{*\}|\%[Bbkf])}}
  local left="%F{$prompt_line_fg}${prompt_head_start}${prompt_line}%f(%B%F{$prompt_distro_fg}${left_raw}%f%b)"

  local right_raw="%n@%B%m%b"
  local right_width=${#${(S%%)right_raw//(\%([KF1]|)\{*\}|\%[Bbkf])}}
  right_raw="%(!.%K{$prompt_root_red}.)%n%(!.%K.)@%B%m%b"  # kinda cheating here
  local right="(%F{$prompt_host_fg}${right_raw}%f)%F{$prompt_line_fg}${prompt_line}%f"


  # Try to fit both parts:
  # .-(~/bar/path)----------------(user@host)-
  local padding_size=$(( COLUMNS - left_width - right_width - (2 + 2 + 2 + 1) ))
  if (( padding_size > 0 )); then
    local padding
    eval "padding=\${(l:${padding_size}::${prompt_line}:)_empty_zz}"
    echo "${left}%F{$prompt_line_fg}${padding}%f${right}"
    return
  fi

  # Try to fit only left part:
  # .-(~/bar/path)-------------
  padding_size=$(( COLUMNS - left_width - (2 + 2 + 1) ))
  if (( padding_size > 0 )); then
    local padding
    eval "padding=\${(l:${padding_size}::${prompt_line}:)_empty_zz}"
    echo "${left}%F{$prompt_line_fg}${padding}%f"
    return
  fi

  # Truncate left part:
  # .-(...ar/path)-
  left_width=$(( COLUMNS - (2 + 2 + 1) ))
  left="%F{$prompt_line_fg}${prompt_head_start}${prompt_line}%f(%B%F{$prompt_distro_fg}%$left_width<${prompt_dots}<${left_raw}%<<%f%b)"
  echo "${left}%F{${prompt_line_fg}}${prompt_line}%f"
}

prompt_ps1_line2() {
  echo "$(prompt_start_input_line)%F{$prompt_host_fg}%B%(!.${prompt_arrow_root}.${prompt_arrow_user})%b%f "
}

prompt_ps2() {
  echo "$(prompt_branch_prev_line)$(prompt_start_input_line)%F{$prompt_distro_fg}%B%_${prompt_arrow_user}%b%f "
}

prompt_ps3() {
  echo "$(prompt_branch_prev_line)$(prompt_start_input_line)%F{$prompt_distro_fg}%B?#%b%f "
}


setopt PROMPT_SUBST PROMPT_CR PROMPT_PERCENT
PS1=$'$(prompt_ps1_line1)\n$(prompt_ps1_line2)'
PS2=$'$(prompt_ps2)'
PS3=$'$(prompt_ps3)'
zle_highlight[(r)default:*]="default:bold"

if [[ ${LC_ALL:-${LC_CTYPE:-$LANG}} = *UTF-8* ]]; then
  prompt_enable_utf8
fi
