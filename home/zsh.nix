{
  pkgs,
  lib,
  config,
  ...
}: let
  scripts = import ../pkgs/scripts.nix {inherit pkgs lib;};
in {
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      defaultKeymap = "viins";
      initExtra = ''
        function precmd() {
          print -Pn "\e]133;A\e\\"
          if ! builtin zle; then
          print -n "\e]133;D\e\\"
          fi
        }
        function preexec {
          print -n "\e]133;C\e\\"
          print -n '\e[5 q'
          print -Pn "\e]0;''${(q)1}\e\\"
        }
        function osc7-pwd() {
          emulate -L zsh
          setopt extendedglob
          local LC_ALL=C
          printf '\e]7;file://%s%s\e\' $HOST ''${PWD//(#m)([^@-Za-z&-;_~])/%''${(l:2::0:)$(([##16]#MATCH))}}
        }
        function chpwd-osc7-pwd() {
          (( ZSH_SUBSHELL )) || osc7-pwd
        }
        add-zsh-hook -Uz chpwd chpwd-osc7-pwd
        bindkey '^[[Z' reverse-menu-complete
        bindkey "^?" autopair-delete
        bindkey '^H' backward-delete-word
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        function fzf-comp-widget() {
          local FZF_CTRL_T_OPTS="--bind 'focus:jump' --bind 'space:jump,jump:accept,jump-cancel:abort' --tac"
          LBUFFER="''${LBUFFER}$(__fzf_select)"
          local ret=$?
          zle reset-prompt
          return $ret
        }
        zle -N fzf-comp-widget
        bindkey "^O" fzf-comp-widget
        setopt interactive_comments nomatch
        unsetopt beep extendedglob notify
        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list "m:{a-z0A-Z}={A-Za-z}"
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' completer _complete _ignored _approximate
        zstyle ':completion:*' verbose true
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
        zstyle ':completion:*' use-cache on
        _comp_options+=(globdots)
        # [[ ! -f "''${ZDOTDIR}/p10k.zsh" ]] || source "''${ZDOTDIR}/p10k.zsh"
        eval "$(oh-my-posh init zsh --config ~/.config/zsh/ohmyposh/config.toml)"
      '';
      syntaxHighlighting = {
        enable = true;
        highlighters = ["main" "brackets" "pattern"];
        patterns = {"rm -rf *" = "fg=0,bg=3";};
        styles = {
          default = "fg=4";
          double-hyphen-option = "fg=6";
          single-hyphen-option = "fg=6";
          assign = "fg=10,bold";
        };
      };
      historySubstringSearch.enable = true;
      dotDir = ".config/zsh";
      history.path = "${config.xdg.dataHome}/zsh/zsh_history";
      history.size = 10000000;
      sessionVariables = {
        DIRENV_LOG_FORMAT = "";
        PROMPT_EOL_MARK = "󱞥";
      };
      plugins = [
        {
          name = "zsh-autopair";
          src = pkgs.zsh-autopair;
          file = "share/zsh/zsh-autopair/autopair.zsh";
        }
        {
          name = "zsh-completions";
          src = pkgs.zsh-completions;
          file = "share/zsh-completions/zsh-completions.zsh";
        }
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
      shellAliases = {
        vi = "nvim";
        up = "nix flake update && nh os switch --ask";
        del = "nh clean all --nogcroots";
        ss = "nh search";
        shell = "nix-shell --run zsh -p";
        cat = "bat -p -P";
        rm = "rm -Ivr";
        mv = "mv -iv";
        cp = "cp -ivr";
        df = "duf";
        mkdir = "mkdir -pv";
        cd = "z";
      };
      autocd = true;
    };

    oh-my-posh = {
        enable = true;
    };
  };

  xdg.configFile."zsh/ohmyposh/config.toml".source = ./ohmyposh.toml;
}
