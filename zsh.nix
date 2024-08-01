{ pkgs, ... }: {
  # .zshenv
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;

    history = {
      ignoreDups = true;
      save = 1000000;
      size = 1000000;
    };

    shellAliases = {
    };

    initExtra = ''
      # Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
   #   export KEYTIMEOUT=1

   #   bindkey '^[[7~' beginning-of-line
   #   bindkey '^[[8~' end-of-line

   #   unalias 9


      eval "$(starship init zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      # theme = "ys";
      plugins = [
        "aws"
        "docker"
        "git"
        "git-extras"
        "man"
        "nmap"
        "sudo"
        "tmux"
        "zsh-navigation-tools"
        "mix"
      ];
    };
  };
}
