# ./modules/intel.nix
{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    videoDrivers = ["intel"]; # 使用 Intel 驱动
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
    ];
  };

  # 不再启用 nvidia
  # hardware.nvidia 配置全部删除
}
