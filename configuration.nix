{ pkgs, cfg, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = { system = "aarch64-linux"; };
  nixpkgs.buildPlatform = { system = cfg.buildSystem; };

  users.users.${cfg.username} = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = cfg.password;
  };

  networking = {
    hostName = cfg.hostname;
    firewall.enable = false;
  };

  services.openssh.enable = true;

}
