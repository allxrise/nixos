_: {
  den.aspects.resolved.nixos = _: {
    networking.nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNSSEC = "true";
        Domains = [ "~." ];
        DNSOverTLS = "true";
        FallbackDNS = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };
    };
  };
}
