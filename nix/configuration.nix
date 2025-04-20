{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    # py-spy
    _1password-cli
    bashInteractive
    bat
    clang-tools
    cmakeCurses
    curl
    delta
    ffmpeg
    fzf
    gcc
    git
    gnumake
    htop
    hyperfine
    imagemagick
    include-what-you-use
    jdk
    jq
    lsd
    maven
    ncdu
    neofetch
    neovim
    ninja
    poppler_utils
    python3
    rclone
    restic
    ripgrep
    samply
    scc
    shellcheck
    stow
    tmux
    uv
    yazi
  ];

  programs.bash.completion.enable = true;

  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder.FXEnableExtensionChangeWarning = false;
    finder.FXPreferredViewStyle = "clmv";
    finder.ShowPathbar = true;
    NSGlobalDomain.InitialKeyRepeat = 25;
    NSGlobalDomain.KeyRepeat = 2;
    dock.autohide = true;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = config.rev or config.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "1password-cli"
    ];
  };
}
