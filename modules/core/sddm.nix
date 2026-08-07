{ inputs, ... }:
{
  flake.nixosModules.sddm =
    { pkgs, ... }:
    let
      qylockThemes = inputs.qylock.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mkSddmThemes { };
    in
    {
      services.displayManager.sddm = {
        enable = true;
        theme = "pixel-night-city";
        extraPackages = [
          qylockThemes
          pkgs.qt6.qt5compat
          pkgs.qt6.qtmultimedia
          pkgs.qt6.qtsvg
        ];
      };

      environment.systemPackages = [ qylockThemes ];

      services.displayManager.autoLogin = {
        enable = true;
        user = "ruzbyte";
      };

      services.displayManager.defaultSession = "niri";
    };
}
