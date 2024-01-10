{ pkgs, ... }:

{
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [ playerctl ];
}
