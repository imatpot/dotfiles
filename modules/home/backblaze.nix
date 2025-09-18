{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config true "backblaze"
{
  home = {
    shellAliases.b2 = "backblaze-b2";

    packages = with pkgs; [
      master.backblaze-b2
    ];
  };
}
