{ pkgs, ... }:

{
  i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-configtool
        fcitx5-gtk
        kdePackages.fcitx5-qt
        (fcitx5-rime.override {
          rimeDataPkgs = [ nur.repos.definfo.rime-ice ];
        })
      ];
  };
}