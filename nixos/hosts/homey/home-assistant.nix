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
    ];
    configWritable = true;
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
    };
  };

  services.mosquitto = {
    enable = true;
    listeners = [
      {
        users = {
          tasmota = {
            acl = [ "readwrite #" ];
            hashedPassword = "$7$101$fortkoOCO04mWhwY$Dky/QZbn5pBUHle0tFwLT+Pu9CFN767tyrIp9VSyY6y/irk8TtT6rwyG3XdyI5jbOUTqqJHYZ3VHhOmOaIEHNQ==";
          };
          home-assistant = {
            acl = [ "readwrite #" ];
            hashedPassword = "$7$101$yTCVaxI32b4Tq3K1$6W87/4eCBjbGw5w9QbS9YRt5oubaSMcvymIUd1xEbO8IaldJcLaJVMp7rFPN0COx6iLWDaSk8TICOxw07OOhiw==";
          };
        };
      }
    ];
  };

  services.caddy.virtualHosts."home.routing.rocks".extraConfig = ''
    import private

    reverse_proxy * [::1]:${toString config.services.home-assistant.config.http.server_port}
  '';
}
