{ ... }: {
  flake.nixosModules.docker = { pkgs, ... }: {
    virtualisation.docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    users.users.zaroc.extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [
      docker-buildx
      docker-compose
    ];
  };
}
