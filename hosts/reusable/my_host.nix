# my_host.nix
{ hostName }:
{
  networking = {
    hostName = hostName;
    hosts = {
      "127.0.0.1" = [
        "localhost"
        hostName
      ];
      "::1" = [
        "localhost"
        hostName
      ];
    };
  };
}
