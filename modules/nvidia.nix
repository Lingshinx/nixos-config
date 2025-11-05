#./modules/nvidia.nix
{config, ...}: {
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
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

      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
  # 可选：屏蔽核显
  # boot.kernelParams = ["modprobe.blacklist=amdgpu,i915"];
}
