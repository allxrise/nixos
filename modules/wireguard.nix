{ lib, inputs, config, ... }: 
{
  imports =
    [
      inputs.sops-nix.nixosModules.sops
    ];

  sops = {
    defaultSopsFile = ./.secrets.yaml;
    age = {
      keyFile = "/home/iso/.sops/key.txt";
      generateKey = false;
    };
    secrets = {
      "wireguard/mullvad" = {};
      "wireguard/umut" = {};
    };
  };

  networking.wg-quick.interfaces = 
  let
    mullvadBgIP = "146.70.188.130:51820";
    mullvadPrivateKeyPath = config.sops.secrets."wireguard/mullvad".path;
    umutIP = "141.148.227.247:51820";
    umutPrivateKeyPath = config.sops.secrets."wireguard/umut".path;
  in 
  {
    mullvad = {
      address = [
        "10.73.42.217/32"
      ];
      dns = [ 
        "1.1.1.1" 
        "1.0.0.1" 
      ];

      listenPort = 51580;
      privateKeyFile = mullvadPrivateKeyPath;

      peers = [{
        publicKey = "J8KysHmHZWqtrVKKOppneDXSks/PDsB1XTlRHpwiABA=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = mullvadBgIP;
      }];
    };
    umut = {
      address = [
        "10.7.0.2/24"
      ];
      dns = [ 
        "1.1.1.1" 
        "1.0.0.1" 
      ];

      listenPort = 51580;
      privateKeyFile = umutPrivateKeyPath;

      peers = [{
        publicKey = "Xq1cc30ne+jAngu/qbHHaZbLgil7WcPpx349sC0bPgc=";
        presharedKey = "JxE5/6PaEoimWbHwcLh30tsPIVi51dOXboM98gBRjcQ=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = umutIP;
      }];
    };
  };

  systemd.services.wg-quick-mullvad.wantedBy = lib.mkForce [ ];
  systemd.services.wg-quick-umut.wantedBy = lib.mkForce [ ];
}
