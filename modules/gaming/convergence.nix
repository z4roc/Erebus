{ inputs, ... }:
{
  flake.nixosModules.elden-ring-convergence = {
    imports = [
      inputs.elden-ring-convergence.nixosModules.default
    ];

    programs.elden-ring-convergence = {
      enable = true;
      user = "ruzbyte";
      installDirectory = "/home/ruzbyte/Games/ConvergenceER";
    };
  };
}
