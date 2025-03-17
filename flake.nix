{
  description = "Neil's first flake";

  inputs.nixpkgs.url = "nixpkgs";

  outputs = { self, nixpkgs }: {
    packages."aarch64-darwin".default = let
      pkgs = nixpkgs.legacyPackages."aarch64-darwin";
    in pkgs.buildEnv {
      name = "home-packages";
      paths = with pkgs; [
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
        scc
        shellcheck
        stow
        tmux
        yazi
      ];
    };
  };
}
