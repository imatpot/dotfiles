{
  outputs,
  config,
  ...
}:
outputs.lib.mkOptionsModule config "gui" {
  enable = outputs.lib.mkDefaultEnableOption false;
}
