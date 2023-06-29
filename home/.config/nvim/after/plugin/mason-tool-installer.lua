require('mason-tool-installer').setup {

  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  ensure_installed = {
    'prisma-language-server',
    'bash-language-server',
    'css-lsp',
    'dockerfile-language-server',
    'editorconfig-checker',
    'eslint-lsp',
    'grammarly-languageserver',
    'html-lsp',
    'htmlbeautifier',
    'jq',
    'json-lsp',
    'jsonlint',
    'lua-language-server',
    'markdownlint',
    'prettier',
    'rust-analyzer',
    'rustfmt',
    'shellcheck',
    'shfmt',
    'solargraph',
    'sql-formatter',
    'standardrb',
    'stylelint',
    'stylelint-lsp',
    'tailwindcss-language-server',
    'terraform-ls',
    'textlint',
    'typescript-language-server',
    'yaml-language-server',
    'yq',
  },
  auto_update = true,
}

