{ ... }: {
  flake.nixosModules.boot =
    { pkgs, ... }:
    let
      bootWindows = pkgs.writeShellApplication {
        name = "boot-windows";
        runtimeInputs = [ pkgs.systemd ];
        text = ''
          systemctl start boot-windows.service
        '';
      };

      bootWindowsDesktop = pkgs.makeDesktopItem {
        name = "boot-windows";
        desktopName = "Reboot into Windows";
        comment = "Set Windows Boot Manager for the next boot and restart";
        icon = "system-reboot";
        exec = "boot-windows";
        categories = [ "System" ];
        terminal = false;
      };
    in
    {
      boot.kernelPackages = pkgs.linuxPackages_latest;

      boot.loader.systemd-boot.enable = false;
      boot.loader.efi.canTouchEfiVariables = true;

      boot.loader.limine = {
        enable = true;
        efiSupport = true;
        enableEditor = false;
        secureBoot.enable = false; # you can enable secure boot if you are in setup mode

        style = {
          wallpapers = [ ../../wallpapers/alpha_pgr.jpg ];
          wallpaperStyle = "stretched";
          interface.branding = "Alpha OS";
        };
      };

      boot.plymouth.enable = true;
      boot.kernelParams = [
        "quiet"
        "splash"
        "udev.log_level=3"
      ];
      boot.consoleLogLevel = 0;
      boot.initrd.verbose = false;

      systemd.services.boot-windows = {
        description = "Set Windows Boot Manager for the next boot and restart";
        path = with pkgs; [
          efibootmgr
          systemd
        ];
        script = ''
          windows_entry_found=false
          while IFS= read -r entry; do
            if [[ $entry =~ ^Boot0000\*?[[:space:]]+Windows[[:space:]]+Boot[[:space:]]+Manager([[:space:]]|$) ]]; then
              windows_entry_found=true
              break
            fi
          done < <(efibootmgr)

          if [[ $windows_entry_found != true ]]; then
            echo "Boot0000 is not Windows Boot Manager; refusing to change BootNext." >&2
            exit 1
          fi

          efibootmgr --bootnext 0000
          systemctl reboot --no-block
        '';
        serviceConfig.Type = "oneshot";
      };

      environment.systemPackages = with pkgs; [
        bootWindows
        bootWindowsDesktop
        efibootmgr
        sbctl
      ];
    };
}
