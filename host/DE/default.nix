{pkgs, ... }: 
{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enbale = true;
}
