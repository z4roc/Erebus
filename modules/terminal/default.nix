{ ... }: {
  flake.nixosModules.terminal = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      fzf
      neovim
      git
      fastfetch
      eza
      zoxide
      stow
      ripgrep
      fd
      yazi
      file
    ];
  };
}
