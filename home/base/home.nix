{ pkgs, ... }:

{
  imports = [
    ./scripts/home.nix
    ./git.nix
    ./tmux.nix
    ./ssh.nix
    ./gpg.nix
    ./zsh.nix
    ./vim.nix
    ./fzf.nix
    ./bat.nix
  ];
  
  programs.home-manager.enable = true;

  home = {
    packages = with pkgs; [
      curl
      inetutils
      coreutils
      hexyl
      btop
      htop
      wget
      jq
      yq
      tree
      exa
      ripgrep
      fd
      dutree
      screen
      watch
      openssl
      p7zip
      meslo-lgs-nf
      asciinema
      openvpn
      wireguard-tools
      podman
      podman-compose
      docker-compose
      yubikey-manager

      # network
      dig
      host
      mtr
      bgpq4
      tcptraceroute
      iperf
      iperf3
      nmap
      ipcalc
      tcpdump
    ];
  };

}
