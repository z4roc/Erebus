{ self, inputs, ... }: {
  flake.nixosModules.miyabiConfiguration = { ... }: {

    imports = [
      inputs.nixos-wsl.nixosModules.default

      self.nixosModules.terminal

      self.nixosModules.ssh

      self.nixosModules.docker
      self.nixosModules.javascript
      self.nixosModules.python
      self.nixosModules.git
      self.nixosModules.cli-tools

      self.nixosModules.home
    ];

    networking.hostName = "miyabi";
    system.stateVersion = "26.05";

    wsl.enable = true;

    programs.nix-ld.enable = true;

    nixpkgs.config.allowUnfree = true;

    time.timeZone = "Europe/Berlin";

    i18n.defaultLocale = "en_US.UTF-8";

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };

    wsl.defaultUser = "zaroc";
  };
}
