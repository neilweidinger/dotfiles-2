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
        # py-spy
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
    };
  };
}
