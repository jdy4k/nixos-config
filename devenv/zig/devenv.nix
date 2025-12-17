{ pkgs, lib, config, inputs, ... }:

{
  env.GREET = "Zig Devenv Intialized";
  starship.enable = true;

  packages = [ pkgs.hello ];
  
  languages.zig = {
    enable = true;
    package = inputs.zig.packages.${pkgs.system}.master;
  };

  enterShell = ''
    echo $GREET
    zig version
  '';
}
