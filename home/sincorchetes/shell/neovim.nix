{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    lua-language-server
    bash-language-server
    pyright
    terraform-ls
    vscode-langservers-extracted
    typescript-language-server
  ];

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      nvim-tree-lua
      lualine-nvim
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
    ];

    initLua = builtins.readFile ./neovim/init.lua;
  };
}
