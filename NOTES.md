# General information about Neovim

This is my scratchpad for information I gather

## Distraction free modes

- zen mode (`<leader>uz`) for less distractions
- Zoom mode (`<leader>uZ`) is similar. One comes from folke, the other from snacks

## Menus

NeoVim running without GUI supports the "PopUp" menu on right mouse button click. I intended to use it, but then I discovered that submenus are not supported in this case. Therefore, I abandoned this path and am using keymaps (with which-keys configured to show descriptions for common prefixes)

## Useful keys to remember

- `<leader>b` for buffers
- `<leader>c` for code actions
- `<leader>d` for debugging (DAP)
- `<leader>f` for file operations (and terminal)
- `<leader>fr` for recent files
- `<leader>g` for git
- `<leader>q` for session management
- `<leader>r` for refactoring
- `<leader>s` for searches
- `<leader><tab>` for tabs
- `<leader>t` for tests
- `<leader>u` for UI reconfiguration
- `<leader>uf` (global) or `<leader>uF` (buffer) to toggle autoformat
- `<leader>uI` to show treesitter tree
- `<leader>w` for windows
- `<leader>x` for diagnostics and similar
- `g` goto (or show).
- `gu`/`gU` changes case
- `gf` within a URL (like <https://neovim.io/doc/user/usr_23.html#usr_23.txt> ), downloads and edits
- `ga` to show ascii code of char in cursor
- `g8` to show byte sequence for UTF8
- `g<ctrl-g>` shows position/total in bytes/words/...
- `g?` is rot13
- `gO` is outline
- `gs` is sleep (like `:sleep`)
- `NNNNgo` to move to byte NNNN
- `]` and `[` to navigate diagnostics, errors, git changes, ...
- `C-r` is redo (opposite of undo). I don't know why I keep forgetting it
  - But in insert mode `C-r` is to insert from a register.
- `C-v` in insert mode to enter special chars literally
  - `C-V NNN` to enter char with decimal code NNN
  - `C-V xHH` to enter char with hex code HH
  - `C-V u xHHHH` and `C-V U xHHHHHHHH` for unicodes
- `C-k char1 char2` for digraphs. Use `digraphs` to show which ones are available. It is possible to define your own with `:digraph`
- `C-o cmd` to execute normal mode command in insert mode. Equivalent to `ESC cmd i`
- `z` is generally for folding, but ...
  - `z=` to suggest spelling corrections
  - `zg` to add to dictionary
  - `zw` to mark as misspelled
- `NN|` goes to column NN (`|` to column 1)
- `G` is last line but `NNG` is line NN
- `(` and `)` to navigate sentences. `{` and `}` for paragraphs
- `*` searches word under cursor
- `A` and `I` also append/insert like `a`/`i` but at the end/beginning of the line
- `=` works like `!` but using `equalprg`
- `K` is keywordprg (if empty then LSP hover??)
- `C-w` for window operations (see also `<leader>-w)` 

All default keys are documented in `:help index`

## Local configs

`.lazy.lua` file at project level is loaded after all other plugins. For per-project configuration

BTW: if `exrc` option is set, then `.nvim.lua` is also sourced.

## trouble.nvim deepdive

It supplies many of the leader-c and leader-x functions. Also the :Trouble command

- syntax in Trouble mode command args
- mode is
  - fzf and fzf_files : result of last fzf search (if enabled)
  - snacks and snacks_files : result of last snacks picker (if enabled)
  - telescope and telescope-files (if enabled)
  - lsp is the combination of the following and opens to the right:
    - lsp_declarations
    - lsp_definitions
    - lsp_implementations
    - lsp incoming_calls
    - lsp outgoing_calls
    - lsp_references
    - lsp_type_definitions
  - symbols==lsp_document_symbols
  - lsp_command ???. Needs params and wraps the LSP "workspace/executeCommand"
  - <Leader>xL loclist
  - <Leader>xQ qflist==quickfix
  - <Leader>xt and <Leader>xT and <Leader><Leader>tt todo (not native, uses folke/todo)
  - <Leader>xx and <Leader>xX diagnostics
  - profiler uses snacks profiler ???
  - [ ] add shortcut: symbol (LSP document symbols) to the right
- command is show (default), toggle, close
- api has also is_open, refresh, get_items, cancel, delete, filter, first, last, next, prev, focus, fold_xxx, help, inspect, jump, jump_close, jump_only, jump_split, jump_split_close, jump_vsplit, jump_vsplit_close, preview, refresh, toggle_preview, toggle_refresh
- args
  - filter
    - filter.buf=0 for only current buffer
    - a function that filters (see advanced example at <https://github.com/folke/trouble.nvim/blob/main/docs/examples.md> for cascading severity)
    - not, any
    - basename, dirname, filename, ft, kind (:h symbol), pos, severity, source
  - focus=true or false to focus or not on newly opened
  - follow to reposition the trouble window as you move in main windows. The opposite seems to always be true, if you click in a trouble the main window moves to the problem
  - win.position=right to decide where to put
  - `pinned` option to pin the buffer as the source for the opened trouble window ??
- In the window:
  - `?` shows help. -`gb` for local buffer filter
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
  - `TSEditQuery group [lang]` edit queries for a group and language. If there are several, a selection menu is shown. If there is none, a new query file is created in user config dir. If lang is not specified, the language of the current buffer is used
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

dial: increase/decrease numbers/dates/... in visual mode with `C-X` and `C-A.` Maybe I remove it later

flash: search with `s` , then type the letter of the red label to jump into it

friendly-snippets: collection of snippets

fzf-lua: All the leader+s and more. ":FzfLua builtin" for metamenu

gitsigns: Related to git editing. It offers several features:

- Marks editing in the gutter (and lualine).
- `[` or `]` with h or H to navigate "hunks".
- `leader+gh` for operations like staging.
- `:Gitsigns` command for things like blame

grug-far: find and replace (`<leader>-sr`)

inc-rename: LSP rename with feedback (`:IncRename` or `<leader>-cr`) 

kulala: REST operations (`leader-R`). This is only present in http or rest filetypes, or in codeblocks.

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
This plugin only highlights. The folke/todo-comment does more, but it works on "cwd" from when you start vim. I found the trick with keymaps but it's not perfect

mini.icons: icons (mostly filetypes) for other plugins

mini.move: move line (or visual block) with alt+l/k/j/h

mini.pairs: auto insert pair for [] {} () "" '' ``

neoconf: Use json files to configure LSP. These files can be:

- global settings: `~/.config/nvim/neoconf.json`
- project root settings: `.../.neoconf.json`
- it can also import from vscode

There is also autocompletion for those files. And in integrates with neodev (whatever that means??)

But I still haven't found a real use for it

neogen: generate annotation (function signatures) Is it really useful?

neotest. framework for testing. see webpage for available adapters

neotest-golang and neotest-python: adapters for go and python

noice: pretty menus, alerts, ...

none-ls: LSP central server

nui: UI components for other plugins

nvim-dap: Debug adapter Protocol. a framework for debugging

nvim-dap-go, nvim-dap-python: adapters for go and python

nvim-dap-ui: UI for nvim-dap

nvim-dap-virtual-text: show variable values in the code while debugging

nvim-jdtls: Java LSP and DAP

nvim-lint: An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.

nvim-lspconfig: configurations for LSP servers. I also used it to reconfigure vim.diagnostic
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

snacks: provides many pickers and extra utils, but I am unsure which ones are finally used and which ones are replaced by other plugins like fzflua.
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

vimtex: support for Latex

which-key: Shows available keymaps

yanky: advanced yank: leader-p <p <P =p =P >p >P TODO: complete

## brief description of LSPs and other things installed with mason

- marksman offers completions (for blink) and an action to create table of contents for markdown
- harper_ls checks spelling and correct writing. Intended for text (or markdown) documents mostly. One of the features is that when you add a known word you can choose the dictionary "level" (user, workspace, file-local, and static)
- vale_ls is similar to harper_ls. It offers several sets of preconfigured rules. But it does not offer code actions to fix or ignore spelling

## concepts

- The location list is local to a window. Open it with :lopen or :lw
- The quickfix list is global. Open it with :copen or :cw
- Some plugins fill one of those lists, some fill the other

- The status line is what you see at the bottom of a window
- The winbar is similar but at the top of the window
- The tabline allows to select which buffer

- conceallevel seems to be automatically managed by some plugins or LSPs. On new blank buffer, I can modify it. But on a markdown file, it stays at 3 even after changing it

- `nvim -d a b` opens in _diff mode_

- modeline must be in the first or last five lines or whatever `:set modelines` says. Use `:set nomodeline` to disable.
  - It helps with setting options such as tab size, line length, ...
  - format is `any-text vim:set {option}={value} ... : any-text`
  - the `any-text` is used to make it look like a comment in whatever language the file is.
  - if `vim:` is not at the start, then you need a space before it
  - escape colons because otherwise the mark the end of the modeline

- verbosity (for `nvim -V10` or `nvim -V20logfile`) is:
  - 1 Enables Lua tracing (see above). Does not produce messages.
  - 2 When a file is ":source"'ed, or |shada| file is read or written.
  - 3 UI info, terminal capabilities.
  - 4 Shell commands.
  - 5 Every searched tags file and include file.
  - 8 Files for which a group of autocommands is executed.
  - 9 Executed autocommands.
  - 11 Finding items in a path.
  - 12 Vimscript function calls.
  - 13 When an exception is thrown, caught, finished, or discarded.
  - 14 Anything pending in a ":finally" clause.
  - 15 Ex commands from a script (truncated at 200 characters).
  - 16 Ex commands.

- when you yank/delete/... a fold, it acts as a single line.

- the old viminfo is now called `shada`. Details in shada option

## marks

These are for use with `'`. You can list them with `:marks`:

- `"` is last position in the buffer
- `.` is last edit on the buffer
- a-z local to the buffer
- A-Z global
- 0 is position when you exited last, 1 is when you exited before that, ... and so on until 9
- `[` start of the previously operated or put text
- `]` end of the previously operated or put text
- `^`
- `<` is visual mode selection start
- `>` is visual mode selection end

Also, `''` jumps to position before last jump

## registers

You fill them with sequences like `"fyas` (yank a sentence, but it goes into register f). Same for deletions. You use them with sequences like `"fp` (paste, but from register f). You list them with `:registers`

In insert mode, C-r register inserts the register

- a-z user registers
- A-Z append to the corresponding lowercase register
- `*` is current selection
- `+` is real clipboard
- 0-9
- `.`
- `"`

## textobjects

`a` (around) is usually "bigger" than `i` (inside) because it also includes delimiters

- w word (letters+numbers+underscore)
- W WORD (any non-blank)
- s sentence (dots)
- p paragraph (blank lines)
- b block (parens)
- B BLOCK (brackets)
- `>` (`<>`)
- t (tag block: xml)
- `'` single quoted string
- `"` double quoted string
- "`" for backquote

## macros

They also use the a-z registers. Record with `q{register}`. Stop recording with `q`. Use with `@{register}` (or `3@x` to repeat 3 times). Re-execute last one with `@@`. Using uppercase letters for recording appends (to the corresponding lowercase register) instead of replacing

## ranges

- `.` is current line
- `$` is last line
- % is equivalent to `1,$`. You can do `:%!`; no need for ":1"+"G"
- both sides can have offsets
- and you can also use searches
- So `:?^Foo?+2,/Bar$/-1s=grey=gray=g` replaces grey by gray in all lines between the second after the previous appearance of Foo at the start and the first before the next appearance of Bar at the end
- when using a `;` to separate, cursor first goes to the first place, so:
  - `/foo/,/bar/` is from first foo (starting here) to first bar (also starting here)
  - `/foo/;/bar/` is from first foo (starting here) to first bar (starting at that foo)
- marks are also allowed: `:'a,'b!sort`
- `:` when in visual mode opens with `'<,'>`

## visual block mode

You trigger with C-V to select a rectangular area. (And, as in visual mode, `o` jumps to the "other side" for adjusting)

Short lines that finish before the block "left border" are not affected

- `$` extends to end of each line
- `Istring<esc>` inserts in every line before the selection
- `Astring<esc>` inserts in every line after the selection
- `cstring<esc>` replaces the selected part in every line
- `Cstring<esc>` replaces until the end in each line
- `u` makes lowercase
- `U` makes uppercase
- `~` swaps case
- `rX` replaces by char X
- `>` and `<` to indent/dedent

## patterns

- almost standard regex, but with things escaped.
- `\c` or `\C` at the beginning of search pattern to ignore/use case ignoring the ignorecase and smartcase settings
- `/pattern/2` to land 2 lines after the search
- `/pattern/e` to land at the end instead of at the beginning
- `/pattern/e+3` to land 3 chars after the end. Also negative values
- `/pattern/b-5` to land 5 chars before the start. Also positive values values
- `*` for 0 or more
- `\+` for 1 or more
- `\(` and `\)` for groups.
- `\%(\)` for non-capturing groups
- `\=` for optional
- `\{n,m}` for n<=x<=m repetitions. `\{,n}` for 0<=x<=n. `\{n,}` for n<=x. `{n}` for exactly n matches
- `{-n,m}` is the same but not greedy. `{-}` is like `*` but not greedy
- `\|` for alternatives
- `\&` for alternatives matching in the same place. (wow!)
- `\[]` for char sets or ranges
- `\e` is escape, `\t` is tab, `\r` is carriage return, `\b` is backspace, `\n` is newline
- `\%d` is decimal, `\%o` is octal, `\%x` is hex, `\%u` and `\%U` is unicode
- `\a` is letters, `\d` is digits, `\x` is hexdigit, `\s` is whitespace, `\w`is word (letter, number, underscore), `\l` is lowercase, `\u` is uppercase
- `\A`, `\D`, `\X`, `\S`, ... are the negations
- `\_x` is like `x` but also matches newlines. So `\_.` matches absolutely everything
- `[=a=]` matches all chars that are equivalent to `a` in the current locale. So accented letters too
- `~` is the last given substitute string
- `\1`, `\2`, ... for groups in the search pattern. Used in replacement too
- `\<` and `\>` stand for begin and end of word.

The `e` flag in a search is for not giving an error if the pattern is not found (useful for macros, because macro execution stops when it finds an error)

## about help

`:help xxx | only` (or `:only` in the help split) to see help in full windows. Initially the help doesn't appear in the bufline, but with `<leader>bb` executed twice it starts appearing. BTW: this applies to other windows too, like `:options`

But an even better way is to prepend with `tab` and then it opens in a new tab: `:tab options`

Another trick to force help and similar to appear in the bufline is `:set buflisted`

`:helpgrep` shows first match, but stores all matches in the quickfix list (so you can explore e.g with `<Leader>xQ`)

Important help pages:

- quickref
- index (for all the default key mappings)

## commands

User defined commands should start with uppercase letter

Restore an option to default value with an ampersand: `:set iskeyword&`

New buffer with `:edit` (but `<leader>e` might be easier)

Append current content to another file with `:write >> somefile`

Save to another file and start working on it with `:saveas anotherfile`. With `:file anotherfile` you also change the name but don't save yet.

Save or quit all windows at once with `:qall` or `:wall` (or `:wqall` to combine)

`:[range]global/{pattern}/{command}` (where `global` is usually abbreviated to `g`) is like `:s/...`. But instead of replacing executes on the matching lines the given command, which is something that you would write after a `:`. You can use `:normal` for normal mode commands. IN this case, the default range is already the whole file

`:read !cmd` to insert command output (or `:0read !cmd` to insert before first line)

`:write !wc` to send to command. **DO NOT CONFUSE** with `:write! wc`, which writes to `wc` file without asking. Note the position of the `!` in both cases

`:!cmd` executes a command (output goes to NoiceAll)

`:terminal` to open a shell

`:Man` to open man pages

`:oldfiles` shows last opened files. `:e <#5` opens number 5. Also other commends like `:vsplit #<5`. But you can get a better result with `<Leader>fr`

`:browse` ???

`:cd` for global cwd, `:lcd` for buffer cwd, `:tcd` for tab cwd, <Leader>`:pwd` to show it

`:buffers` or `:ls` lists buffers (not really needed if you have the buf/tab line)

`:iab` to create abbreviations, `:iunab` to remove. Also similar with `:cabb`, and noremap versions too. `:abclear` to remove them all. Do we really need this having snippets? (TBC)

`:{range}center [width]` to center a line. `:{range}right [width]` to right align. `:{range}left [margin]` to left align

`:argdo` to execute a command in all files (args of nvim). `:windo` for all windows, `:bufdo` for all buffers

`:retab` combined with `set expandtabs` to convert all tabs to spaces

`:undolist`, `:earlier`, `:later` and complex u / C-R ???

`:map` and all the variants (or equivalent lua)

`:help letter<C-D>` shows all maps??

`:jumps` shows the jump list

redirect:

- `:redir > file` to send to a file. `:redir! > file` to overwrite existing. `:redir >> file` to append
- `:redir @{register}`
- `:redir => {variable}` (`=>>` to append) for variables
- `:redir END`

`:filter {pattern} {command}` to restrict output. `:filter!` to negate

`:silent {command}` to suppress output. `:silent!` to also suppress errors. redirect still gets the output

`:[count]verbose {command}` to execute with verbosity (the one between 0 and 16)

`:browse {command}` browses for file and uses for the command (e.g `:bro e`)

`:e[dit]` without arguments reopens current file. For a new empty buffer use `:enew`

TODO: full syntax for `:command`

TODO: autocmd

TODO: tags related

TODO: <https://neovim.io/doc/user/quickref.html#Q_qf>

## options

textwidth for automatic line split. Set to 0 to disable. `gq` reformats

virtualedit can be useful to edit tables with holes in them

shada has comma separated options: `shada=!,'100,<50,s10,h`

- `!` is global variables that start with uppercase and do not have lowercase
- `<N` is max lines saved per register. synonym with `"`
- '%' is buffer list
- `'N` is how many files will have their marks remembered
- `/N` is how many search patters to remember (the value of history if not specified)
- `:N` is how many command history to remember (the value of history if not specified)
- `@N` is how many input line to remember (the value of history if not specified)
- `h` is no hlsearch
- `sN` max item size

### see quickref
