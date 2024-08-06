{
  description = "Miredo service flake with firewall configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    pkgsFor = forAllSystems (system: nixpkgs.legacyPackages.${system});
  in {
    nixosModules.default = {
      config,
      pkgs,
      lib,
      ...
    }: let
      cfg = config.services.miredo;
    in {
      options.services.miredo = {
        enable = lib.mkEnableOption "Miredo Teredo client";
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.miredo;
          description = "The Miredo package to use.";
        };
        serverAddress = lib.mkOption {
          type = lib.types.str;
          default = "teredo.remlab.net";
          description = "The Teredo server to use.";
        };
        bindAddress = lib.mkOption {
          type = lib.types.str;
          default = "0.0.0.0";
          description = "The local address to bind to.";
        };
        bindPort = lib.mkOption {
          type = lib.types.port;
          default = 3545;
          description = "The local port to bind to.";
        };
        interfaceName = lib.mkOption {
          type = lib.types.str;
          default = "teredo";
          description = "The name of the Teredo interface.";
        };
      };

      config = lib.mkIf cfg.enable {
        systemd.services.miredo = {
          description = "Miredo Teredo Client Daemon";
          after = ["network.target"];
          wantedBy = ["multi-user.target"];
          serviceConfig = {
            ExecStart = "${cfg.package}/bin/miredo -f -c ${pkgs.writeText "miredo.conf" ''
              InterfaceName ${cfg.interfaceName}
              ServerAddress ${cfg.serverAddress}
              BindAddress ${cfg.bindAddress}
              BindPort ${toString cfg.bindPort}
            ''}";
            Restart = "always";
          };
        };

        networking.firewall = {
          allowedUDPPorts = [cfg.bindPort];
          extraCommands = ''
            ${pkgs.iptables}/bin/iptables -I INPUT -p udp --dport 3544 -j ACCEPT
            ${pkgs.iptables}/bin/iptables -I OUTPUT -p udp --dport 3544 -j ACCEPT
          '';
          extraStopCommands = ''
            ${pkgs.iptables}/bin/iptables -D INPUT -p udp --dport 3544 -j ACCEPT || true
            ${pkgs.iptables}/bin/iptables -D OUTPUT -p udp --dport 3544 -j ACCEPT || true
          '';
        };

        boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = lib.mkDefault 1;
      };
    };

    nixosConfigurations = forAllSystems (
      system: let
        pkgs = pkgsFor.${system};
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            self.nixosModules.default
            ({...}: {
              services.miredo = {
                enable = true;
                serverAddress = "teredo.remlab.net";
              };
            })
          ];
        }
    );

    packages = forAllSystems (
      system: let
        pkgs = pkgsFor.${system};
        miredoWrapper = pkgs.writeShellScriptBin "miredo-wrapper" ''
          #!/bin/sh
          set -e

          if [ "$(id -u)" -ne 0 ]; then
            echo "This script must be run as root" >&2
            exit 1
          fi

          TEMP_DIR=$(mktemp -d)
          trap 'rm -rf "$TEMP_DIR"' EXIT

          ${pkgs.miredo}/bin/miredo -f -c ${pkgs.writeText "miredo.conf" ''
            InterfaceName teredo
            ServerAddress teredo.remlab.net
            BindAddress 0.0.0.0
            BindPort 3545
          ''} --pidfile="$TEMP_DIR/miredo.pid"
        '';
      in {
        default = miredoWrapper;
      }
    );

    apps = forAllSystems (system: {
      default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/miredo-wrapper";
      };
    });
  };
}
