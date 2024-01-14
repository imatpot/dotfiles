{ outputs, ... }:

{
  isLinux = outputs.lib.hasSuffix "linux";
  isDarwin = outputs.lib.hasSuffix "darwin";
}
