{
  sessionPath = [ "/home/mladen/.npm-packages/bin" ];

  # Less Nix-ish but it makes it easier for me
  file.".npmrc".text = "prefix = /home/mladen/.npm-packages";
}
