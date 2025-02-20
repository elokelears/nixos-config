{pkgs, ...}: 

{
  services.dae = {
    enable = true;
    package = pkgs.dae;
    configFile = ./config.dae;
  };
}
