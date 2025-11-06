{ pkgs, lib, inputs, ... }:

let
  # needs to match Stackage LTS version from stack.yaml snapshot
  ghc = "ghc910";
  hsPkgs = pkgsUnstable.haskell.packages.${ghc};

  pkgsUnstable =
    import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };

in {
  dotenv.enable = true; # .env
  dotenv.disableHint = true; # .env

  # VSCode devcontainer https://devenv.sh/integrations/codespaces-devcontainer/
  devcontainer.enable = true;

  # https://devenv.sh/packages/
  packages = [
    pkgs.ghcid
  ];

  # https://devenv.sh/languages/
  languages.nix.enable = true;
  languages.haskell.enable = true;
  languages.haskell.package = pkgsUnstable.haskell.compiler.${ghc};
  languages.haskell.languageServer = hsPkgs.haskell-language-server;

  # TODO: devenv 1.8.2+ does most of this by default
  languages.haskell.stack = let
  in pkgs.symlinkJoin {
    name = "stack"; # will be available as the usual `stack` in terminal
    paths = [ pkgsUnstable.stack ];
    buildInputs = [ pkgs.makeWrapper ];
    # NOTE: we use hpack on purpuse from pkgs/devenv-rolling channel
    # This makes sure that stack uses the same hpack as we do when
    # we run hpack manually. Ideally we would have languages.haskell.hpack option
    # to overwrite the default hpack package but its not available yet.
    postBuild = ''
      wrapProgram $out/bin/stack \
        --add-flags "--no-nix --system-ghc --no-install-ghc --with-hpack ${
          lib.getExe pkgs.hpack
        }"
    '';
  };


  # NOTE: profiles are available on devenv 1.9
  # # See profile reference https://devenv.sh/profiles/
  # # CI profile
  # profiles.ci.module = {
  #   env.HOOGLE_ENABLE = "false";
  #   # Generating hie in CI forces recompilation so we turn it off
  #   env.GHC_OPTIONS = "-fno-write-ide-info +RTS -A128m -n2m -RTS";
  # };

  # See full reference at https://devenv.sh/reference/options/
}
