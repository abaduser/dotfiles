{ config, pkgs, ... }:

# https://github.com/nix-community/home-manager/tree/master/modules/

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zircon";
  home.homeDirectory = "/home/zircon";

  # Enable genericLinux support
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    # 
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "Lilex" ]; })
    # 
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.neovim
    pkgs.lsd
    pkgs.tmux
    pkgs.zoxide
    pkgs.python3
    pkgs.cargo
    pkgs.rustc
    pkgs.vscode
    pkgs.gnucash
  ];
  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = "abaduser";
    userEmail = "abaduser.pw@proton.me";
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "lsd";
      ll = "lsd -l";
      update = "sudo apt update && sudo apt upgrade && sudo snap refresh && nix-channel --update && home-manager switch";
      dotfiles = "~/.nix-profile/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
      custom = "$HOME/.config/oh-my-zsh-custom/";
    };
  };
  
  programs.fzf = {
    enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zircon/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
