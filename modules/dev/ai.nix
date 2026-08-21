{ ... }: {
  flake.nixosModules.ai = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      claude-code
      codex
      (pkgs.callPackage ../../packages/t3code.nix { })
      opencode
    ];

    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };

    services.open-webui = {
      enable = true;
    };
  };
}
