{ pkgs, ... }:

{
  i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-configtool
        fcitx5-gtk
        kdePackages.fcitx5-qt
        # 覆盖后要把.local/share/fcitx5/rime下的文件删除，否则不会生效
        (fcitx5-rime.override {
          rimeDataPkgs = [ nur.repos.definfo.rime-ice ];
        })
      ];
  };
}