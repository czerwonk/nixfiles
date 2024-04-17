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
      "esphome"
      "met"
      "radio_browser"
      "hue"
      "mqtt"
    ];
    config = {
      default_config = {};
      homeassistant = {
        name = "routing-rocks HOME";
      };
      http = {
        server_host = "::1";
        trusted_proxies = [ "::1" ];
        use_x_forwarded_for = true;
      };
    };
  };

  services.caddy.virtualHosts."home.routing.rocks".extraConfig = ''
    import private

    reverse_proxy * [::1]:${config.services.home-assistant.config.http.server_port}
  '';
}
