{ lib, pkgs, ... }:

{
  programs.zed-editor = {
    userSettings = {
      lsp = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true;
                nilness = true;
                shadow = true;
                unusedwrite = true;
                useany = true;
              };
              staticcheck = true;
              codelenses = {
                generate = true;
                gc_details = true;
                test = true;
                tidy = true;
                upgrade_dependency = true;
                vendor = true;
              };
            };
          };
        };
        typescript-language-server = {
          initialization_options = {
            preferences = {
              includeInlayParameterNameHints = "all";
              includeInlayParameterNameHintsWhenArgumentMatchesName = true;
              includeInlayFunctionParameterTypeHints = true;
              includeInlayVariableTypeHints = true;
              includeInlayVariableTypeHintsWhenTypeMatchesName = true;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayFunctionLikeReturnTypeHints = true;
              includeInlayEnumMemberValueHints = true;
            };
          };
        };
        nil = {
          initialization_options = {
            formatting = {
              command = [
                "${lib.getExe pkgs.nixfmt-rfc-style}"
              ];
            };
          };
        };
      };
    };
  };

  home.packages = with pkgs; [
    marksman
    nil
    terraform-ls
  ];
}
