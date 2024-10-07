{ ... }:

{
  modules.users = {
    gaming = {
      wine.enable = true;
      proton.enable = true;
      steam.enable = true;
      lutris.enable = true;

      games = {
        minecraft.enable = true;
        pokemmo.enable = true;
      };
    };
  };
}
