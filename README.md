# IC10LSP

A simple language server for the IC10 MIPS-like language in the game Stationeers.

Features:

- Completions (not fully)
- Hover information
- Signature help
- Goto definition
- Diagnostic information

![Demo](demo.gif)

## Configuration

The language server exposes the following configuration options:

| Key                         | Description                                      | Default |
| --------------------------- | ------------------------------------------------ | ------- |
| max_lines                   | Maximum number of lines                          | 128     |
| max_columns                 | Maximum number of columns                        | 52      |
| warnings.overline_comment   | Emit a warning on comments past the line limit   | true    |
| warnings.overcolumn_comment | Emit a warning on comments past the column limit | true    |

## Commands

The language server exposes the following commands:

| Command | Description                                            |
| ------- | ------------------------------------------------------ |
| version | Show a message with the version of the language server |


## To add stuff

Add instructions, Logic types, etc. Just add them in their structs and doc structs in the instruction.rs.
Then recompile.

## Install in Nvim
If you have a default mason install on linux then you can symlink the binary in ~/.local/share/nvim/mason/bin/
You can then add this to your nvim config
```
vim.filetype.add { extension = { ic10 = 'ic10' } }
vim.lsp.config['ic10'] = {
  cmd = { 'ic10lsp' },
  filetypes = { 'ic10' },
}
vim.lsp.enable 'ic10'
```
