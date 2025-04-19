{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # py-spy
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

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = config.rev or config.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
