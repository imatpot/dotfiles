{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config true "neovim"
{
  home = {
    packages = with pkgs; [nixvim];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      GIT_EDITOR = "nvim";
    };
  };
}
