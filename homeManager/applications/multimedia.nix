{ pkgs, lib, ... }:

{

  home = {
    
    packages = with pkgs ; [
      pavucontrol
      easyeffects
      qpwgraph
      ffmpeg_7-full
      gst_all_1.gstreamer
      gst_all_1.gst-vaapi
      gst_all_1.gst-plugins-ugly
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-libav
      gimp
      inkscape
      obs-studio
      mpv
      spotify
      vlc
      stremio
      heroic
    ];
  };
}
