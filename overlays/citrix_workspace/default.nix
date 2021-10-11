{ citrix_workspace, lib }:
citrix_workspace.overrideAttrs (oldAttrs: {
  src = assert oldAttrs.version == "21.9.0.25"; ./citrix_workspace_21.9.0.25.tar.gz;
})
