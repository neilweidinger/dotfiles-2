{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    _1password-cli
    ast-grep
    bandwhich
    bashInteractive
    bat
    btop
    claude-code
    colima
    curl
    delta
    difftastic
    dive
    docker
    docker-compose
    fd
    ffmpeg
    fzf
    ghostty-bin
    git
    herdr
    htop
    hyperfine
    imagemagick
    jless
    jq
    lsd
    ncdu
    neovim
    ouch
    poppler-utils
    procs
    py-spy
    python3
    rclone
    restic
    restic-browser
    ripgrep
    rsync
    rustup
    samply
    scc
    shellcheck
    snitch
    stow
    thunderbird
    tmux
    trippy
    uv
    wireshark
    yazi
    vlc-bin
    yq-go
    yt-dlp
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    brews = [ ];
    casks = [
      "1password"
      "claude"
      "cold-turkey-blocker"
      "daisydisk"
      "handbrake-app"
      "iina"
      "jetbrains-toolbox"
      "jordanbaird-ice"
      "keepingyouawake"
      "monitorcontrol"
      "mullvad-vpn"
      "obsidian"
      "selfcontrol"
      "transmission"
      "utm"
      "whatsapp"
      "zoom"
      # alfred
      # aerospace/amethyst/rectangle - something for window management
    ];
  };

  # Manage the terminal font declaratively
  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  # Register the Nix-installed bash in /etc/shells so it's a valid login shell.
  # This removes the manual step of editing /etc/shells; `chsh` is still a
  # one-time manual command (see README).
  environment.shells = [ pkgs.bashInteractive ];
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

  nix = {
    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";

    gc = {
      # Automatically garbage collect and hard-link identical store files.
      # `--delete-older-than 30d` prunes system/home generations older than 30 days
      # so their store paths become collectable; without it, bare nix-collect-garbage
      # only frees paths unreachable from any gcroot (and every generation is a
      # gcroot), so old generations would never be reclaimed. Keeps 30 days of
      # rollback history.
      automatic = true;
      options = "--delete-older-than 10d";
    };

    optimise.automatic = true;
  };

  # Enable Touch ID for sudo
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
    reattach = true;
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "1password-cli"
        "claude-code"
        "claude-code-bin"
      ];
  };
}
