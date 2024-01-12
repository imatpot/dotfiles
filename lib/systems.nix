{ lib, ... }:

{
  isLinux = lib.hasSuffix "linux";
  isDarwin = lib.hasSuffix "darwin";
}
