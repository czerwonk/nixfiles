{ pkgs, username, ... }:

{
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  users.users.${username} = {
    packages = with pkgs; [
      pavucontrol
    ];
  };
}
