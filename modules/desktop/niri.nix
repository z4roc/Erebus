{ ... }: {
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      kitty
      wl-clipboard
      cliphist
      noctalia
      xwayland-satellite
      fuzzel
    ];
  };
}
