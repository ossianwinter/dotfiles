{ pkgs, ... }:
{
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;

  # Used by PipeWire to acquire realtime scheduling priority.
  security.rtkit.enable = true;

  # Pulls pw-jack into the global environment.
  environment.systemPackages = with pkgs; [ pipewire.jack ];
}
