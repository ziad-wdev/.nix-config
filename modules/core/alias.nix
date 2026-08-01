{
  lib,
  username,
  ...
}: {
  imports = [
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" username])
  ];
}
