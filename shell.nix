{ pkgs ? import <nixpkgs> { overlays = (import ./overlays.nix {}); },
  nix-ada ? import ../nix-ada { pkgs = pkgs; }
}:
pkgs.mkShell {
  nativeBuildInputs = [ 
    pkgs.gnat 
    pkgs.alire 
    nix-ada.alire-index 
    nix-ada.gtkada
    pkgs.gprbuild 
    pkgs.gnatcoll-core 
    nix-ada.aws 
    nix-ada.gnat_util 
    nix-ada.gnat-gdb-scripts 
    nix-ada.gnatstudio 
  ];
#   nativeBuildInputs = [ nix-ada.gtkada nix-ada.pkgs.gprbuild nix-ada.pkgs.gnatPackages.gpr2 nix-ada.pkgs.gnat nix-ada.pkgs.alire nix-ada.gnatstudio ];
#   nativeBuildInputs =[ nix-ada.gnatcoverage ];
#   nativeBuildInputs = [ nix-ada.wayland-ada-scanner ];
}
