{
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;
  };

  services.zfs = {
    autoSnapshot.enable = true;
    autoScrub.enable = true;
  };
}

