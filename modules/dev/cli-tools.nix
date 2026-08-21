{ ... }: {
  flake.nixosModules.cli-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      claude-code
      codex
      (pkgs.callPackage ../../packages/t3code.nix { })
      opencode
      nil
      nixfmt
      nixd
      prettier
      stylua
      lazygit
      tree-sitter
      gcc
    ];
  };
}
