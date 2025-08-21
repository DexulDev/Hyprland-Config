# ~/.config/fish/config.fish

if status is-interactive
    # Starship custom prompt
    starship init fish | source

    # Custom colours from Caelestia
    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null

    # For jumping between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end
end

# ===== ALIASES =====
alias ll='ls -l'
alias la='ls -a'
alias l='ls'
alias g='git'
alias v='nvim'
alias c='clear'
alias FUCKING='sudo'
alias gh='cd ~'
alias home='cd ~'
alias minecraft='flatpak run com.modrinth.ModrinthApp'
alias cat='bat'
alias find='fd'
alias gnu-ls='command ls --color=auto'
alias gnu-grep='command grep --color=auto'
function steam
    STEAM_FORCE_DESKTOPUI_SCALING=1 /usr/bin/steam $argv
end

function cacheclear
    echo "Limpiando caché de paquetes..."
    sudo paccache -r
    echo "Limpiando logs antiguos..."
    sudo journalctl --vacuum-time=7d
    echo "Limpieza completa."
end


# ===== FUNCIONES PERSONALIZADAS =====

function raptor
    cd ~/.local/share/raptor/publish
    dotnet raptor.dll
end

function fzf-search --description 'Busqueda fuzzy con fzf'
    if test (count $argv) -eq 0
        ls | fzf
    else
        ls | grep $argv | fzf
    end
end

function git-branch-fzf
    git branch -a | string trim | string replace -r '\* ' '' | string replace 'remotes/origin/' '' | sort -u | fzf
end

# ===== KEYBINDINGS =====

function __fzf_insert_history
    commandline --replace (history | string split '\n' | uniq | fzf --layout=reverse --height=40% | string trim)
end

function __fzf_insert_file
    commandline --insert (fd --type f --hidden --follow --exclude .git | fzf --layout=reverse --height=40%)
end

function __fzf_cd_dir
    set dir (fd --type d --hidden --follow --exclude .git | fzf --layout=reverse --height=40%)
    if test -n "$dir"
        cd "$dir"
    end
end

bind \cr '__fzf_insert_history'
bind \ct '__fzf_insert_file'
bind \ec '__fzf_cd_dir'

# ===== VARIABLES Y CARGAS EXTRAS =====

# Fastfetch
# fastfetch

# Oh My Posh (si lo usas además de Starship)
source ~/.cache/oh-my-posh.nu 2> /dev/null

# LD_LIBRARY_PATH para MySQL Workbench
set -x LD_LIBRARY_PATH /usr/lib/mysql-workbench $LD_LIBRARY_PATH

# oh-my-posh para Fish
oh-my-posh init fish --config ~/.config/oh-my-posh/clean-detailed-with-user.omp.json | source

zoxide init fish | source

set -gx FZF_DEFAULT_OPTS "--layout=reverse --height=40% --border --margin=1 --padding=1 --color=bg:#24273A,bg+:#363A4F,spinner:#F4DBD6,hl:#96CDFB --color=fg:#CAD3F5,header:#96CDFB,info:#C6A0F6,pointer:#F4DBD6 --color=marker:#F4DBD6,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#96CDFB"
set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"

# ===== SPICETIFY =====
# set -gx PATH $PATH "$HOME/.spicetify"



