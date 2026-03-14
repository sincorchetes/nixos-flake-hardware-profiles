{ pkgs, osConfig, ... }:

let
  # Automatically detect NVIDIA from the system configuration
  hasNvidia = builtins.elem "nvidia" (osConfig.services.xserver.videoDrivers or [ ]);

  # ArtCNN C4F32 DS - Neural network luma doubler with denoise + sharpen
  # https://github.com/Artoriuz/ArtCNN
  artcnnShader = pkgs.writeText "ArtCNN_C4F32_DS.glsl" (builtins.readFile ./shaders/ArtCNN_C4F32_DS.glsl);

  # --- Shared (base) config ---
  baseConfig = {
    # Video Output & API
    vo = "gpu-next";
    gpu-api = "vulkan";
    gpu-shader-cache-dir = "~/.cache/mpv/shaders";

    # Quality
    profile = "high-quality";

    # Deband (disabled by default, toggle with 'd')
    deband = false;
    deband-iterations = 2;
    deband-threshold = 35;
    deband-range = 20;
    deband-grain = 5;

    # Base scaling
    cscale = "ewa_lanczos";
    cscale-antiring = 0.7;
    dscale = "mitchell";

    # Frame Timing & Smoothness
    video-sync = "display-resample";
    interpolation = true;
    tscale = "oversample";

    # HDR & Tone Mapping
    target-colorspace-hint = true;
    tone-mapping = "bt.2446a";
    hdr-compute-peak = true;

    # OSD & Interface
    osd-font-size = 25;
    osd-scale-by-window = true;
    osd-font = "sans-serif";
    sub-font-size = 40;
    sub-scale-by-window = true;
    osd-margin-x = 20;
    osd-margin-y = 20;

    # Behavior
    keep-open = true;
  };

  # --- NVIDIA extras (CUDA/NVDEC + ArtCNN) ---
  nvidiaConfig = {
    hwdec = "nvdec";
    hwdec-extra-frames = 16;
    hwdec-codecs = "all";
    glsl-shader = "${artcnnShader}";
    scale = "ewa_lanczossharp";
  };

  # --- Extras for Intel (VA-API) ---
  intelConfig = {
    hwdec = "vaapi";
    hwdec-codecs = "all";
    scale = "ewa_lanczossharp";
  };

in
{
  programs.mpv = {
    enable = true;
    config = baseConfig // (if hasNvidia then nvidiaConfig else intelConfig);

    bindings = {
      # --- Debanding control ---
      "h" = "add deband-threshold 12";
      "j" = "add deband-threshold -12";
      "H" = ''show-text "Deband Threshold: ''${deband-threshold}"'';
    };
  };
}
