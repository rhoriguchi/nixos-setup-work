{ citrix_workspace, lib }:
citrix_workspace.overrideAttrs (oldAttrs: {
  # TODO client version is actually 21.9.0.25
  src = assert oldAttrs.version == "21.8.0.40"; ./citrix_workspace_21.9.0.25.tar.gz;
})
