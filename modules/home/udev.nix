{
  outputs,
  config,
  ...
}:
outputs.lib.mkOptionsModule config true "udev" {
  extraRules =
    with outputs.lib;
    mkOption {
      default = [ ];
      type = types.listOf <| types.either types.path types.str;
      apply =
        rules:
        with builtins;
        let
          paths = rules |> filter isPath |> map readFile;
          strings = rules |> filter isString;
        in
        [
          paths
          strings
        ]
        |> outputs.lib.flatten
        |> builtins.concatStringsSep "\n";
    };
}
