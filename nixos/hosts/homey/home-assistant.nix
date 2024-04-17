{ inputs, ... }:

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
        server_host = "127.0.0.1";
      };
    };
  };

  services.caddy.virtualHosts."home.routing.rocks".extraConfig = ''
    import private

    reverse_proxy * 127.0.0.1:8123
  '';
}
