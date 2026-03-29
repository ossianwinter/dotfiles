{ ... }:
{
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;

  # Used by PipeWire to acquire realtime scheduling priority.
  security.rtkit.enable = true;
}
