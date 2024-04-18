{ inputs, config, ... }:

{
  disabledModules = [
    "services/home-automation/home-assistant.nix"
  ];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/home-automation/home-assistant.nix"
  ];

  services.home-assistant = {
    enable = true;
    extraComponents = [
      "met"
      "hue"
      "mqtt"
      "tasmota"
      "tradfri"
      "smartthings"
    ];
    config = {
      default_config = {};
      homeassistant = {
        name = "#routing-rocks HOME";
      };
      http = {
        server_host = "::1";
        trusted_proxies = [ "::1" ];
        use_x_forwarded_for = true;
      };
      "automation ui" = "!include automations.yaml";
    };
  };

  services.mosquitto = {
    enable = true;
    listeners = [
      {
        users = {
          tasmota = {
            acl = [ "readwrite #" ];
            hashedPassword = "$7$101$rd+Gnz+J36Wg/y2e$OO5JENYzk/dn46TirOGaWqf++6JLKgNBhyStqL5AJS20weNXSg4ReVpq6ceNVIC0guTSfTkZQKNFGMfXPaG04A==";
          };
          home-assistant = {
            acl = [ "readwrite #" ];
            hashedPassword = "$7$101$yTCVaxI32b4Tq3K1$6W87/4eCBjbGw5w9QbS9YRt5oubaSMcvymIUd1xEbO8IaldJcLaJVMp7rFPN0COx6iLWDaSk8TICOxw07OOhiw==";
          };
        };
      }
    ];
  };

  networking.firewall.allowedTCPPorts = [ 1883 ];

  services.caddy.virtualHosts."home.routing.rocks".extraConfig = ''
    import private

    reverse_proxy * [::1]:${toString config.services.home-assistant.config.http.server_port}
  '';
}
