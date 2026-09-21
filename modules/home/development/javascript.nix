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
    master.nodejs
    unstable.bun
  ];
}
