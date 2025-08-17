{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    # py-spy
    _1password-cli
    bashInteractive
    bat
    btop
    clang-tools
    cmakeCurses
    curl
    delta
    dive
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
    rsync
    rustup
    samply
    scc
    shellcheck
    stow
    tmux
    uv
    yazi
    yq-go
    yt-dlp
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    brews = [ ];
    casks = [
      "1password"
      "alacritty"
      "daisydisk"
      "iina"
      "jetbrains-toolbox"
      "keepingyouawake"
      "monitorcontrol"
      "mullvadvpn"
      "obsidian"
      "protonvpn"
      "selfcontrol"
      "transmission"
      "utm"
      "whatsapp"
      "zoom"
      # alfred
      # aerospace/amethyst/rectangle - something for window management
      # chrome
      # ice/onlyswitch
    ];
  };

  programs.bash.completion.enable = true;

  system = {
    defaults = {
      NSGlobalDomain.InitialKeyRepeat = 25;
      NSGlobalDomain.KeyRepeat = 2;
      dock.autohide = true;
      finder.AppleShowAllExtensions = true;
      finder.FXEnableExtensionChangeWarning = false;
      finder.FXPreferredViewStyle = "clmv";
      finder.ShowPathbar = true;
    };

    # Set Git commit hash for darwin-version.
    configurationRevision = config.rev or config.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;

    # Seems to be required by `nix-darwin` as some kind of transition phase
    # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.primaryUser
    primaryUser = "neilweidinger";
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "1password-cli" ];
  };
}
