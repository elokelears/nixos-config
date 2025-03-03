{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  dpkg,
  makeDesktopItem,
  copyDesktopItems,
  alsa-lib,
  cairo,
  dbus,
  expat,
  fontconfig,
  gcc-unwrapped,
  glib,
  gtk3,
  libdrm,
  libnotify,
  libsecret,
  libxkbcommon,
  mesa,
  nss,
  xorg,
  lib,
  ...
}: let
  pkgver = "1.3.10";
  debSha256 = "336e4690c0c6d588600e0f4697f85ff06bf4bba22a29c4fdc59e1f57eb7a8a2a";
  desktopItems = [
    (makeDesktopItem {
      name = "windsurf";
      desktopName = "Windsurf";
      exec = "windsurf";
      icon = "windsurf";
      comment = "Tomorrow's Editor, Today";
      categories = ["Development" "IDE"];
      mimeTypes = ["x-scheme-handler/windsurf"];
    })
  ];
in
  stdenv.mkDerivation rec {
    pname = "windsurf-bin";
    version = pkgver;

    src = fetchurl {
      url = "https://github.com/samex/windsurf-ai-arch-linux/releases/download/${version}/Windsurf-linux-x64-${version}.deb";
      sha256 = debSha256;
    };

    nativeBuildInputs = [
      autoPatchelfHook
      dpkg
      copyDesktopItems
    ];

    buildInputs = [
      alsa-lib
      cairo
      dbus
      expat
      fontconfig
      gcc-unwrapped.lib
      glib
      gtk3
      libdrm
      libnotify
      libsecret
      libxkbcommon
      mesa
      nss
      xorg.libX11
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXrandr
      xorg.libxcb
      xorg.libxkbfile
    ];

    installPhase = ''
      runHook preInstall

      # 主程序安装
      mkdir -p $out/usr/share/windsurf
      cp -r usr/share/windsurf/* $out/usr/share/windsurf

      # 二进制链接
      mkdir -p $out/bin
      ln -s $out/usr/share/windsurf/windsurf $out/bin/windsurf

      # 桌面文件
      mkdir -p $out/share/applications
      cp ${desktopItems}/share/applications/* $out/share/applications

      # 图标安装
      mkdir -p $out/share/icons/hicolor/128x128/apps
      cp ${./windsurf.png} $out/share/icons/hicolor/128x128/apps/windsurf.png

      # Shell补全
      mkdir -p $out/share/bash-completion/completions
      cp ${./windsurf-bash-completion} $out/share/bash-completion/completions/windsurf
      mkdir -p $out/share/zsh/site-functions
      cp ${./windsurf-zsh-completion} $out/share/zsh/site-functions/_windsurf

      runHook postInstall
    '';

    meta = with lib; {
      description = "AI-powered code editor with instant developer assistance";
      homepage = "https://codeium.com/";
      license = licenses.mit;
      platforms = ["x86_64-linux"];
      maintainers = [maintainers.yourname];
    };
  }
