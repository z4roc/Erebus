{ inputs, ... }: {
  flake.nixosModules.steam = { pkgs, ... }: {
    imports = [
      inputs.aagl.nixosModules.default
    ];

    # nix.settings = inputs.aagl.nixConfig;

    programs.steam.enable = true;
    # programs.honkers-railway-launcher.enable = true;

    hardware.steam-hardware.enable = true;

    environment.systemPackages = with pkgs; [
      # basic packages
      lutris
      mangohud
      protonplus
      protontricks
      wineWow64Packages.stagingFull
      winetricks

      prismlauncher
      # osu-lazer-bin
    ];
    users.users."zaroc" = {
      extraGroups = [ "input" ];
    };
  };
}
