_: {
  den.aspects.zapret.nixos = { pkgs, ... }: (
    let
      LIST_PATH = "/zapret/lists/list-zapret.txt";
      ALL_IPSET = "/zapret/lists/ipset-all.txt";
    in {
      services.zapret = {
        enable = true;
        udpSupport = true;
        udpPorts = [
          "19294:19344"
          "50000:50100"
          "443"
          "1024:65535"
        ];

        blacklist = [ "search.nixos.org" ];

        params = [
          # UDP 443 - General Hostlist
          "--filter-udp=443 --hostlist=${LIST_PATH} --dpi-desync=fake --dpi-desync-repeats=6 --new"

          # Discord UDP (Voice/STUN)
          "--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=6 --new"

          # Discord TCP (Media/Image Servers)
          "--filter-tcp=2053,2083,2087,2096,8443 --hostlist-domains=discord.media --dpi-desync=fake,split2 --dpi-desync-repeats=4 --dpi-desync-fooling=ts --new"

          # General TCP (80, 443)
          "--filter-tcp=80,443 --hostlist=${LIST_PATH} --dpi-desync=fake,split2 --dpi-desync-repeats=4 --dpi-desync-fooling=ts,md5sig --new"

          # UDP 443 - IPSET All
          "--filter-udp=443 --ipset=${ALL_IPSET} --dpi-desync=fake --dpi-desync-repeats=6 --new"

          # TCP IPSET + Games (1024-65535)
          "--filter-tcp=80,443,1024-65535 --ipset=${ALL_IPSET} --dpi-desync=fake,split2 --dpi-desync-repeats=4 --dpi-desync-fooling=ts --new"

          # UDP Games (1024-65535)
          "--filter-udp=1024-65535 --ipset=${ALL_IPSET} --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-repeats=12 --dpi-desync-any-protocol=1 --dpi-desync-cutoff=n2 --new"
        ];
      };

      networking.firewall = {
        enable = true;
        allowedUDPPorts = [ 53 ];
        allowedTCPPorts = [ 53 ];
        extraCommands = ''
          ip46tables -t mangle -I POSTROUTING -p tcp --dport 12 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
          ip46tables -t mangle -I POSTROUTING -p tcp --dport 6695:6710 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
          ip46tables -t mangle -I POSTROUTING -p tcp --dport 2053 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
          ip46tables -t mangle -I POSTROUTING -p tcp --dport 2083 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
          ip46tables -t mangle -I POSTROUTING -p tcp --dport 2087 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
          ip46tables -t mangle -I POSTROUTING -p tcp --dport 2096 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
          ip46tables -t mangle -I POSTROUTING -p tcp --dport 8443 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
        '';
      };
    }
  );
}
