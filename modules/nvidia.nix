#./modules/nvidia.nix
{
  config,
  ...
}:
{

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    prime = {
      sync.enable = true; # 强制显示输出走 NVIDIA
      amdgpuBusId = "PCI:8:0:0"; # 集显 BusID
      nvidiaBusId = "PCI:1:0:0"; # 独显 BusID
    };

    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
