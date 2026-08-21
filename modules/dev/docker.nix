{ ... }: {
  flake.nixosModules.docker = { pkgs, ... }: {
    virtualisation.docker = {
      enable = true;
      daemon.settings.features.cdi = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    users.users.ruzbyte.extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [
      docker-buildx
      docker-compose
    ];
  };
}
