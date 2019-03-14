with (import <nixpkgs> {});

let
  ghcEnv = haskell.packages.ghc822.ghcWithPackages(pkgs: with pkgs; [
    (haskellPackages.callPackage ./default.nix {})
    stack
  ]);
  hie =
    (import (
      fetchFromGitHub {
        owner = "domenkozar";
        repo = "hie-nix";
        rev = "6794005f909600679d0b7894d0e7140985920775";
        sha256 = "0pc90ns0xcsa6b630d8kkq5zg8yzszbgd7qmnylkqpa0l58zvnpn";
        # date = 2019-02-11T18:14:42+07:00;
      }
    ) {}).hie82;
in mkShell {
  buildInputs = [
    ghcEnv
    haskellPackages.ghcid
    haskellPackages.hlint
    haskellPackages.hoogle
    haskellPackages.structured-haskell-mode
    haskellPackages.stylish-haskell
    hie
  ];
}
