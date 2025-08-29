{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule'' config "gui" {
  enable = outputs.lib.mkDefaultEnableOption false;
}
