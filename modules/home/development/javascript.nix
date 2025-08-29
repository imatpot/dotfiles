{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.javascript"
{
  home.packages = with pkgs; [
    unstable.deno
    unstable.nodejs
  ];
}
