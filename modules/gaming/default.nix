{ inputs, ... }: {
  flake.nixosModules.steam = { pkgs, ... }: {
    imports = [
    ];

    programs.steam.enable = true;

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
