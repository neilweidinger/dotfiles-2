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
    clang-tools
    claude-code
    cmakeCurses
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
    git
    htop
    hyperfine
    imagemagick
    jless
    jq
    lsd
    ncdu
    neovim
    ninja
    numbat
    ouch
    poppler-utils
    procs
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
    # Homebrew 6.0 removed the `--force-cleanup` flag that nix-darwin still emits
    # for onActivation.cleanup = "uninstall"/"zap" (see nix-darwin modules/homebrew.nix,
    # added by PR #1789). Until upstream switches to HB6 flags, keep cleanup = "none"
    # so that flag isn't emitted, and supply the correct flags ourselves via extraFlags
    # (appended verbatim to `brew bundle`): `--cleanup` enables cleanup during install,
    # `--zap` zaps casks instead of uninstalling, and `--force` skips HB6's interactive
    # "Do you want to proceed with the cleanup?" prompt. Drop all once nix-darwin is fixed.
    onActivation.cleanup = "none";
    onActivation.extraFlags = [ "--cleanup" "--zap" "--force" ];
    brews = [ ];
    casks = [
      "1password"
      "alacritty"
      "daisydisk"
      "handbrake"
      "iina"
      "jetbrains-toolbox"
      "jordanbaird-ice"
      "keepingyouawake"
      "monitorcontrol"
      "mullvadvpn"
      "obsidian"
      "selfcontrol"
      "sf-symbols"
      "transmission"
      "utm"
      "whatsapp"
      "xcodes"
      "zoom"
      # alfred
      # aerospace/amethyst/rectangle - something for window management
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

  # Workaround for https://github.com/nix-darwin/nix-darwin/issues/1817
  # nixpkgs-unstable removed `nixos-render-docs`'s `--toc-depth` flag before
  # nix-darwin adapted, breaking the manual build. Disabling documentation
  # (and the uninstaller, which evaluates its own doc-enabled sub-system)
  # sidesteps it. Remove once PR #1818 lands upstream.
  documentation.enable = false;
  system.tools.darwin-uninstaller.enable = false;

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
