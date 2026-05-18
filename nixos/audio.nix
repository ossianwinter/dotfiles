{ ... }:
{
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;

  # Used by PipeWire to acquire realtime scheduling priority.
  security.rtkit.enable = true;
}
