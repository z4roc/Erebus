{ inputs, ... }: {
  flake.nixosModules.chat = { pkgs, ... }: {
    environment.systemPackages = [
      # inputs.chatgpt.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.teams-for-linux
      (pkgs.discord.override { withVencord = true; })
    ];
  };
}
