{
  pkgs,
  lib,
  ...
}:
{
  systemd.user.services.easyeffects.Service.Environment = [
    "QT_QPA_PLATFORM=offscreen"
  ];

  home.file.".local/share/easyeffects/irs/Razor Surround ((48k Z-Edition)) 2.Stereo +20 bass Low Latency.irs".source =
    pkgs.fetchurl {
      url = "https://github.com/JackHack96/EasyEffects-Presets/raw/refs/heads/master/irs/Razor%20Surround%20((48k%20Z-Edition))%202.Stereo%20+20%20bass%20Low%20Latency.irs";
      sha256 = "sha256-mg27oBVR3h68pLLZ3kputU5fY+iHIsK3d9FNuIrGntQ=";
    };

  services.easyeffects = {
    enable = true;
    preset = "bassPlusPerfectEQ";
    extraPresets = {
      "bassPlusPerfectEQ" = lib.fromJSON (
        lib.readFile (
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/refs/heads/master/Bass%20Enhancing%20%2B%20Perfect%20EQ%20-%20Low%20Latency.json";
            sha256 = "sha256-ujU6g7fGzxyjLO1eXtsJxhc3UdM4DYyo1Hy6IAvdFL4=";
          }
        )
      );
    };
  };
}
