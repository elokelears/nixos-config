{ config, lib, pkgs, ... }:
{

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["amd"];

}
