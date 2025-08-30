{
  outputs,
  config,
  ...
}:
# TODO: set modules.gui.enable on all users without infinite recursion
outputs.lib.mkOptionsModule config false "gui" {}
