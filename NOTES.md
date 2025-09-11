# General information about Neovim

This is my scratchpad for information I gather

## Distraction free modes

- zen mode (`<leader>uz`) for less distractions
- Zoom mode (`<leader>uZ`) is similar. One comes from folke, the other from snacks

## Menus

NeoVim running without GUI supports the "PopUp" menu on right mouse button click. I intended to use it, but then I discovered that submenus are not supported in this case. Therefore I abandoned this path and am using keymaps (with which-keys configured to show descriptions for common prefixes)

## Useful keys to remember

- `<leader>uf` (global) or `<leader>uF` (buffer) to toggle autoformat
- `<leader>b` for buffers
- `<leader>c` for code actions
- `<leader>d` for debugging (DAP)
- `<leader>g` for git
- `<leader>r` for refactoring
- `<leader>s` and `<leader>f` for searches
- `<leader>t` for tests
- `<leader>u` for UI reconfiguration
- `<leader>uI` to show treesitter tree
- `<leader>w` for windows
- `<leader><tab>` for tabs
- `<leader>x` for diagnostics and similar
- `g` goto (or show)
- `]` and `[` to navigate diagnostics, errors, git changes, ...
- C-r is redo (opposite of undo). I don't know why I keep forgetting it
- But in insert mode C-r is to insert from a register. 

All default keys are documented in `:help index`

## Local configs

`.lazy.lua` file at project level is loaded after all other plugins. For per-project configuration

BTW: if `exrc` option is set, then `.nvim.lua` is also sourced.

## trouble.nvim deepdive

It supplies many of the leader-c and leader-x functions. Also the :Trouble command

- syntax in Trouble mode command args
- mode is
  - fzf and fzf_files : result of last fzf search (if enabled)
  - snacks and snacks_files : result of last snacks picker  (if enabled)
  - telescope and telescope-files  (if enabled)
  - lsp is the combination of the following and opens to the right:
    - lsp_declarations
    - lsp_definitions
    - lsp_implementations
    - lsp incoming_calls
    - lsp outgoing_calls
    - lsp_references
    - lst_type_definitions
  - symbols==lsp_document_symbols
  - lsp_command ??? . Needs params and wraps the LSP "workspace/executeCommand"
  - ºxL loclist
  - ºxQ qflist==quickfix
  - ºxt and ºxT and ººtt todo (not native, uses folke/todo)
  - ºxx and ºxX diagnostics
  - profiler uses snacks profiler ???
  - [ ] add shortcut: symbol (LSP document symbols) to the right
- command is show (default), toggle, close
- api has also is_open, refresh, get_items, cancel, delete, filter, first, last, next, prev, focus, fold_xxx, help, inspect, jump, jump_close, jump_only, jump_split, jump_split_close, jump_vsplit, jump_vsplit_close, preview, refresh, toggle_preview, toggle_refresh
- args
  - filter
    - filter.buf=0 for only current buffer
    - a function that filters (see advanced example at  <https://github.com/folke/trouble.nvim/blob/main/docs/examples.md> for cascading severity)
    - not, any
    - basename, dirname, filename, ft, kind (:h symbol), pos, severity, source
  - focus=true or false to focus or not on newly opened
  - follow to reposition the trouble window as you move in main windows. The opposite seems to always be true, if you click in a trouble the main window moves to the problem
  - win.position=right to decide where to put
  - `pinned` option to pin the buffer as the source for the opened trouble window ??
- In the window:
  - `?` shows help.
    -`gb` for local buffer filter
  - jump (double click or enter) moves again to main window at the exact point of the error
  - dd for delete complains modifiable is false, unless you set preview.scratch=false
  - z... for folding

## nvim-tree-sitter

It offers these commands related to treesitter parser:

- info:
  - `TSInstallInfo` (shows installed parsers)
  - `TSModuleInfo` shows info about installed modules
- install
  - `TSInstall <lang>` (autocompletion)
  - `TSUPdate <lang>` updates one, `TSUpdate` updates all installed
  - `TSUninstall <lang>`
- enable/disable
  - `TSBufEnable <module>` enables a module for the current buffer
  - `TSBufDisable <module>` disables a module for the current buffer
  - `TSBufToggle <module>` toggles a module for the current buffer
  - `TSEnable <module> [lang]` enables a module globally for the session. If lang is given, only for that language
  - `TSDisable <module> [lang]` disables a module globally for the session. If lang is given, only for that language
  - `TSToggle <module> [lang]` toggles a module globally for the session. If lang is given, only for that language
- query:
  - `TSEditQuery group [lang]` edit queries for a group and language. if there are several, a selection menu is shown. If ther is none, a new query file is created in user config dir. if lang is nto specified, the language of the current buffer is used
  - `TSeditQueryUserAfter group [lang]` is the same but in the "after" directory. Useful to add custom extensions

One important command (but it is offered by NeoVim itself; not this plugin) is `:InspectTree`

## Brief description of other plugins

_WARNING_: This might be inaccurate and needs markdown formatting.

aerial: provides `:AerialToggle` (should be bound to leader-cs but outline hijacked it) and `:AerialNavTogle`.
This opens a symbol browser. `?` in the window opens keyboard help

blink & blink-copilot: are completion related.

bufferline: controls buffers and tabs at the top of the window

catppuccin: a theme (unused?)

conform: a formatter. Invoked with leader-cf and leader-cF

copilot: completion with GitHub Copilot

crates: for crates.io dependencies (rust)

dial: increase/decrease numbers/dates/... in visual mode with C-X and C-A. Maybe I remove it later

flash: search with `s` , then type the letter of the red label to jump into it

friendly-snippets: collection of snippets

fzf-lua: All the leader+s and more. ":FzfLua builtin" for metamenu

gitsigns: Related to git editiing. It offers several features:

- Marks editing in the gutter (and lualine).
- `[` or `]` with h or H to navigate "hunks".
- leader+gh for operations like staging.
- :Gitsigns command for things like blame

grug-far: find and replace (leader-sr)

inc-rename: LSP rename with feedback (:IncRename or leader-cr)

kulala: REST operations (leader-R). This is only present in http or rest filetypes, or in codeblocks.

lazydev configures LuaLS. I still haven't understood what it does

lazy: the core loader

LazyVim: all the defaults, configs, ... of lazyvim

lua-console and neorepl were added by me for lua debugging

lualine: The bottom status line. Also the top status line, called "winbar"

luasnip: snippet engine

markdown-preview: leader-cp. Under WSL, it insists on using cmd.exe, so I created a symlink

mason-lspconfig: bridges mason and lspconfig ??
provides :LspInstall as a wrapper of :MasonInstall. Without arguments it offers those relevant for current filetype. With one argument, those for that filetype

mason.nvim: package manager for LSP, dap servers, linters, formatters

mason-nvim-dap: to take care of debug adapters

mini.ai: for `a`/`i` (around/inside) textobjects. Textobjects are used in virtual mode or after an operator.
So for example `di(` deletes inside parenthesis and `da(` also deletes the enclosing parenthesis
The plugin adds more textobjects.

mini.files: leader-fm (or leader-fM) file explorer

mini.hipatterns: configurable highlighting of patterns like TODO, FIXME, HACK, NOTE, ...
This plugin only higlights. The folke/todo-comment does more, but it works on "cwd" from when you start vim. I found the trick with keymaps but it's not perfect

mini.icons: icons (mostly filetypes) for other plugins

mini.move: move line (or visual block) with alt+l/k/j/h

mini.pairs: auto insert pair for [] {} () "" '' ``

neoconf: Use json files to configure LSP. These files can be:

- global settings: `~/.config/nvim/neoconf.json`
- project root settings: `.../.neoconf.json`
- it can also import from vscode

There is also autompletion for those files. And in integrates with neodev (whatever that means??)

But I still haven't found a real use for it

neogen: generate annotation (function signatures) Is it really useful?

neotest. framework for testing. see webpage for available adapters

neotest-golang and neotest-python: adapters for go and python

noice: pretty menus, alerts, ....

none-ls: LSP central server

nui: UI components for other plugins

nvim-dap: Debug adapter Protocol. a framework for debugging

nvim-dap-go, nvim-dap-python: adapters for go and python

nvim-dap-ui: UI for nvim-dap

nvim-dap-virtual-text: show variable values in the code while debugging

nvim-jdtls: Java LSP and DAP

nvim-lint: An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.

nvim-lspconfig: configurations for LSP servers. I also used it to reconfigured vim.diagnostic
LSPs are enabled with vim.lsp.enable('server_name')

nvim-metals: Scala LSP

nvim-navic: LSP symbol navigation for lualine. Does it work out of the box or do I need
it also recommends [navbuddy](https://github.com/hasansujon786/nvim-navbuddy)

nvim-nio: library for async io for other plugins

nvim-treesitter-textobjects: textobjects based on treesitter. defines some and allows to define more

nvim-ts-autotag: auto close and rename html tags `<strong>xx</strong>`

one-small-step-for-vimkind: DAP adapter for lua. see webpage for quickstart

outline: outline (ie. TOC, index) browser .Toggle with leader-cs

persistence: save status automatically. restore from initial nvim dashboard

plenary: misc utils library used by other plugins

refactoring: implements the leader-r functions (some only in visual mode)

render-markdown: makes markdown nicer. Inside vim screen; do not confuse with markdown preview, that shows in external browser

rustaceanvim: advanced LSP for Rust

schemastore: used by yaml and json LSPs

snacks: provides many pickers and extra utils utils, but I am unsure which ones are finally used and which ones are replaced by other plugins like fzflua.
snacks has several components; use checkhealth to see each one. Leader keys and what they search:

- , buffers
- / grep root dir
- : command history
- space files root dir
- n notifications
- f many things (see whichkey)
- g also many git-related things

todo-comments by folke is supposed to highlight, have lists, ... but it works at folder level, not current buffer. I am keeping it but may remove later

tokyonight: color scheme

ts-comments: some auxiliary lib

vim-dadbod\*: database interface. command :DB or :DBUI or leader-D

vim-helm. Syntax for helm

vim-illuminate: highlight other uses of the word under the cursor. uses LSP

vim-startuptime: to profile startup time

vimtex: suport for Latex

which-key: Shows available keymaps

yanky: advanced yank: leader-p <p <P =p =P >p >P TODO: complete

## brief description of LSPs and other things installed with mason

- marksman offers completions (for blink) and an action to create table of contents for markdown
- harper_ls checks spelling and correct writing. Intended for text (or markdown) documents mostly. One of tjhe features is that when you add a known word you can choose the dictionary "level" (user, workspace, file-local, and static)
- vale_ls is similar to harper_ls. It offers several sets of preconfigured rules. But it does not offer code actions to fix or ignore spelling

## concepts

- The location list is local to a window. Open it with :lopen or :lw
- The quickfix list is global. Open it with :copen or :cw
- Some plugins fill one of those lists, some fill the other

- The status line is what you see at the bottom of a window
- The winbar is similar but at the top of the window
- The tabline allows to select which buffer

- conceallevel seems to be automatically managed by some plugins or LSPs. On new blank buffer, I can modify it. But on a markdown file, it stays at 3 even after changing it
- marks for use with `'`. You can list them with `:marks`:
  - `"`  is last position in the buffer
  - `.` is last edit on the buffer
  - a-z local to the buffer
  - A-Z global
  - 0-9
  - `[`
  - `]`
  - `^`
  - `<`

- registers. You fill them with sequences like `"fyas` (yank a sentence, but it goes into register f). Same for deletions. You use them with sequences like `"fp` (paste, but from register f). You list them with `:registers`
 - a-z user registers
 - A-Z append to the corresponding lowercase register
 - `*` is current selection
 - `+` is real clipboard
 - 0-9
 - `.`
 - `"`

- macros. They also use the a-z registers. Record with `q{register}`. Stop recording with `q`. Use with `@{register}` (or `3@x` to repeat 3 times). Rexecute last one with `@@`. Using uppercase letters for recording appends (to the corresponfing lowercase register) instead of replacing

- `nvim -d a b` opens in *diff mode*
## about help

`:help xxx | only` (or `:only` in the help split) to see help in full windows. Initially the help doesn't appear in the bufline, but with `<leader>bb` executed twice it starts appearing. BTW: this applies to other windows too, like `:options`

But an even better way is to prepend with `tab` and then it opens in a new tab: `:tab options`

`:helpgrep` shows first match, but stores all matches in the quickfix list (so you can explore e.g with `ºxQ`)

Important help pages:
 - quickref
 - index (for all the default key mappings)

## commands

Restore an option to default value with an ampersand: `:set iskeyword&`

New buffer with `:edit` (but `<leader>e` might be easier)

Append current content to another file with `:write >> somefile`

Save to another file and start working on it with `:saveas anotherfile`. With `:file anotherfile` you also change the name but don't save yet.

Save or quit all windows at once with `:qall` or `:wall` (or `:wqall` to combine)


