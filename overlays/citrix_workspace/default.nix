{ citrix_workspace, lib }:
citrix_workspace.overrideAttrs (oldAttrs: {
  # TODO check with derivation hash
  src = assert lib.versions.splitVersion oldAttrs.version == [ "21" "6" "0" "28" ]; ./citrix_workspace_21.6.0.28.tar.gz;
})
