#./modules/nvidia.nix
{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
      ];
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      prime = {
        sync.enable = true; # 强制显示输出走 NVIDIA
        offload.enable = false; # 启用 PRIME Offload
        amdgpuBusId = "PCI:8:0:0"; # 集显 BusID
        nvidiaBusId = "PCI:1:0:0"; # 独显 BusID
      };

      # package = config.boot.kernelPackages.nvidiaPackages.latest;
      package = pkgs.linuxPackages_latest.nvidiaPackages.latest;
    };
  };
}
