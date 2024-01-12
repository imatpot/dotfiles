{ lib, ... }:

{
  isLinux = lib.hasSuffix "linux";
  isMacOS = lib.hasSuffix "darwin";
}
