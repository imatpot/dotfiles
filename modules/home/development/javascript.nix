{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.javascript"
{
  home.packages = with pkgs; [
    unstable.deno
    unstable.nodejs
  ];
}
