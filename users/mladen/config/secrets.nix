{ config, inputs, outputs, system, hostname, ... }:

outputs.lib.mkFor system hostname {
  hosts.mcdonalds = {
    sops.secrets = {
      kubeConfigOnprem = outputs.lib.mkSecretFile {
        source = "${inputs.vault}/kubernetes/config-onprem.crypt";
        destination = "${config.home.homeDirectory}/.kube/config-onprem";
      };
      kubeConfigNatron = outputs.lib.mkSecretFile {
        source = "${inputs.vault}/kubernetes/config-natron.crypt";
        destination = "${config.home.homeDirectory}/.kube/config-natron";
      };
    };
  };
}
