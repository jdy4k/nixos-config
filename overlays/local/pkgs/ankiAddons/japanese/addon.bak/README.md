Fork of [Ajatt-Tools/Japanaese](https://github.com/Ajatt-Tools/Japanese) for compatibility with Nixos.

This is a temporary (bad) fix. Currently, if you install from the main repository with

``` nix
(pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
  pname = "AJT Japanese";
  version = "v25.5.15.0";
  src = pkgs.fetchFromGitHub {
    owner = "Ajatt-Tools";
    repo = "Japanese";
    rev = "1c993fdb90c771fd5e154bd4e2b57e12a3ca1991";
    hash = "sha256-oQ38Gmvwp1dSgrUZA9pz4DAxPrbQDrhsGoi+BSNh3fs=";
    fetchSubmodules = true;
  };
  sourceRoot = "${finalAttrs.src.name}/japanese";
}))
```
the addon will try to write to databases in its local directory on Anki's launch, which is not possible as the addon is installed within the nix store. I have set the `user_files_dir()` function to return `$HOME/.local/share/Anki2` for now, and the addon seems to work.

You can also use this repo if you like by adding the following into your home-manager configuration:

``` nix
programs.anki = {
  enable = true;
  addons = [
    (pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
      pname = "AJT Japanese";
      version = "v25.5.15.0";
      src = pkgs.fetchFromGitHub {
        owner = "jdy4k";
        repo = "Japanese-nixos";
        rev = "11111111111111111111111"; # replace this; one way to find the
                                         # rev is running `git rev-parse HEAD` 
                                         # in a clone of the repo
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # replace this; 
                # rebuilding with this set to just A's will give you an 
                # error with the correct hash
        fetchSubmodules = true;
      };
      sourceRoot = "${finalAttrs.src.name}/japanese";
    }))
  ];
};
```
