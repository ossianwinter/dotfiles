{ ... }: {
  home.file.".psqlrc" = {
    enable = true;
    target = ".psqlrc";
    text = ''
      # Automatically decide if output should be in the expanded format
      \x auto

      # Show NULL values as (null) instead of blank spaces
      \pset null '(null)'
    '';
  };
}
