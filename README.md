# My NeoVim config

While experimenting with NeoVim, I am tweaking the configuration. This repository will over time accumulate my
customizations in the hope that it can help others facing my same problems.

<!--toc:start-->
- [My NeoVim config](#my-neovim-config)
  - [My setup](#my-setup)
  - [Changes in `./lua/config/lazy.lua`](#changes-in-luaconfiglazylua)
  - [Legacy Vimscript config](#legacy-vimscript-config)
  - [Other config changes](#other-config-changes)
    - [autocommands.lua](#autocommandslua)
    - [keymaps.lua](#keymapslua)
    - [options.lua](#optionslua)
  - [Plugins](#plugins)
    - [noice (bring back the command line)](#noice-bring-back-the-command-line)
    - [tokyonight (colors)](#tokyonight-colors)
    - [which-key](#which-key)
    - [chitshit (example of locally developed plugin)](#chitshit-example-of-locally-developed-plugin)
    - [blink and copilot](#blink-and-copilot)
    - [lualine](#lualine)
    - [markdownlint-cli2](#markdownlint-cli2)
    - [nvim-lspconfig](#nvim-lspconfig)
    - [conform debugging](#conform-debugging)
    - [todo-comments](#todo-comments)
    - [luaconsole and neorepl](#luaconsole-and-neorepl)
    - [codecompannion](#codecompannion)
    - [mini-hipatterns](#mini-hipatterns)
    - [snacks](#snacks)
  - [Miscellaneous information](#miscellaneous-information)
    - [Distraction free modes](#distraction-free-modes)
    - [Useful keys to remember](#useful-keys-to-remember)
    - [Local configs](#local-configs)
    - [trouble.nvim deepdive](#troublenvim-deepdive)
    - [Brief description of plugins](#brief-description-of-plugins)
    - [concepts](#concepts)
  - [License](#license)
<!--toc:end-->

## My setup

I am using [LazyVim](https://www.lazyvim.org/) as the base, so the initial structure is that of the [starter](https://github.com/LazyVim/starter)

The config goes under `~/.config/nvim`. But I was accustomed to my configuration being in `~/.vim` so I created a
symbolic link from `~/.nvim` to `~/.config/nvim`

## Changes in `./lua/config/lazy.lua`

I like to know about new plugin versions, so I have set `lazy.checker.notify = true` in `./lua/config/lazy.lua`.
But once per day is enough, so I have set `lazy.checker.frequency = 86400`. You can always force a check by running
`:Lazy update`.

## Legacy Vimscript config

In [init.lua](init.lua) you can see (commented out) how to include [legacy Vimscript](legacy.vim) configuration
files. I used it initially for some key mappings that I have converted since then into lua.

## Other config changes

Inside `lua/config` there are 3 files than you can tweak. As far as I know, it really doesn't matter in which file you put
your changes, but I try to follow the suggested convention:

- `autocommands.lua` for autocommands
- `keymaps.lua` for key mappings
- `options.lua` for changing options

### autocommands.lua

Call me paranoid, but I don't like my passwords to be sent to copilot. An autocommand here sets a special filetype
`passtxt` for any file containing the string `pass` in its name (you can always change that manually with
`:set filetype=whatever`).

This is complemented later with an option to disable copilot for that filetype

Note: with the blink/copilot cycle trick, copilot starts disabled anyway for any file, including password files. But I am keeping this anyway

There is another autocommand in the file for the blink/copilot combination explained [later](#blink-and-copilot)

### keymaps.lua

The default settings use left/right arrows to navigate the command line completion. This is unintuitive for me, as
the possible completions are laid out vertically, so I prefer to use up/down arrows. The file includes this change.

I also create shortcuts for my experimental plugin `chitshit`.

There is another keymap in the file for the blink/copilot combination explained [later](#blink-and-copilot)

When adding new keymaps, or selecting keys for fine-tuning other plugins, you need 2 things:

1. Knowing if some key is going to conflict with something else. For that you can do `:help insert-index` (or
   similar) to know the builtin keys, and which-key, `FzfLua keymaps` or chitshit to know additions from plugins
2. But you also need to know how to send those keys. For example in a Spanish keyboard, the `[` is obtained by
   pressing `AltGr + <the key containing [>`. So a combination like `<M-[>` is impossible because (Because "meta"
   is "alt", at least in my PC).

So I have created a debug tool (triggered in normal mode with `<leader><leader>cx`) that prints what Vim sees
when you press keys.
You exit it by pressing `x`. With this I discovered some things interesting for me (your results may be totally different):

- Some keypresses didn't _reach_ vim because they were captured by Windows Terminal ( I run NeoVim under WSL).
  But I was never going to use those Windows Terminal features and could remove them from Windows Terminal config
  and make them available for VIM
- Some of the keys didn't work as expected. E.g ctrl+1 sends `1`, not `<C-1>`, ctrl+2 sends `<C-space>`, ...
  Fortunately, among these quirks I found that I can achieve `<C-]` by pressing ctrl+5, or `<C-\>` by pressing
  ctrl+`<`. Some of those would have been difficult or impossible otherwise in my keyboard
- The numbering of function keys is strange:
  - Plain function keys generate `<F-1>` to `<F-12>`
  - With shift they generate `<F13>` to `<F24>`
  - With ctrl they generate `<F25>` to `<F36>`
  - With shift and control they generate `<F37>` to `<F48>`
  - With alt (meta) they generate `<F49>` to `<F60>`
  - And with shift and alt they generate `<F61>` to `<F72>`
  - ... But then with control+alt the generated key is `<M-C-F1>` to `<M-C-F12>`
  - And with shift+control+alt it is `<M-C-S-F1>` to `<M-C-S-F12>`

The file also contains keymaps for my tweak in `todo-comments`. See [section below](#todo-comments)

### options.lua

- Here is where I tell copilot to skip the files with the `passtxt` filetype that I created in autocommands.
- Paths for the python provider
- Disable unused providers
- Some personal preferences related to how I like to see things displayed
- Leader keys comfortable for me in a Spanish keyboard
- Disable autoformat, as I prefer to decide manually when to do that, either with `<Leader>cf` or with `:LazyFormat`

## Plugins

File [lazyvim.json](lazyvim.json) defines the extra plugins that you want to use. But it is much easier to modify
that with the `LazyExtras` menu from inside NeoVim.

For other plugins, you create files under `lua/plugins`.

Files in that folder are only loaded in they end in `.lua`. You can therefore keep files with other names like
`.lua.no` so you can activate by simply renaming them.

You may want to put files under `lua/plugins` for the following reasons:

- To add some plugin that is not contemplated by LazyVim (not even with LazyExtras)
- To modify the default configuration of a plugin that LazyVim provides
- To disable a plugin that LazyVim provides by default (by setting `enabled = false`). You can have one file for
  each plugin that you want to disable, like in [this example](lua/plugins/disable_example.lua.no). Or you may
  disable several plugins with a single file, like in [this other example](lua/plugins/disable_several_example.lua.no)

One trick that I found can be seen [in this file](lua/plugins/debug_cfg_example.lua.no). Replace the plugin name
at the beginning (and rename any other file for the same plugin) and you will get a file with the options that
LazyVim is using for that plugin.
This can be useful to find parameters to tweak.

EDIT: I found a better way to do that. Look at [this file](lua/plugins/zzz_dbg.lua.no). The file name must be such so it comes (alphabetically) after all the other files.
This is becasue lazy.nvim "merges" the files in alphabetically order so you want the debug to happen after any other customizations have been applied.

Whenever I add a file to reconfigure a provided plugin, I add `optional = true` so the file is not forcing the plugin if it later disappears from my setup.

### noice (bring back the command line)

I am a long time user of Vim, so my "muscle memory" is used to the command line at the bottom of the screen. This
is managed by the `noice` plugin, and I created a [file](lua/plugins/noice.lua) to revert back to old behavior.

### tokyonight (colors)

I am too lazy to explore and decide on color schemes, so I am using the default one provided by LazyVim, which is
tokyonight. But there were some things that I had to tweak:

- The line between splits (that you can drag with the mouse to resize) was almost impossible to find.
- The ghost text that copilot+blink provides was too dark for my taste.

So I created a [file](lua/plugins/tokyonight.lua) to tweak the colors.

### which-key

I love this plugin, with only one small "but": If the pop-up is too long, then to scroll through it you need to use
some keys (that appear documented at the bottom of the pop-up) . By default these scrolling keys are ctrl-u and
ctrl-d. I tried to map to up/down arrows and quickly found a problem: they did not work as expected because those
keys by themselves are already used outside which-key. I ended up using Shift+Up and Shift+Down as a second best
option. I created a [file](lua/plugins/which-key.lua) to do that.

In that file, I also added a keymap (ctrl+alt+w) to activate which-key in insert mode.

### chitshit (example of locally developed plugin)

This is my own plugin, and I am using it to learn about plugins, lua, ...
The interesting part are lines 2 and 3. By commenting one or the other, you can easily switch between a local copy
and the one on GitHub. I switch to local, do some development, and once finished I `git push`, switch back to
GitHub version, refresh (`U` in `:Lazy` screen) and check that it still works.

### blink and copilot

By default, LazyVim integrates copilot.lua into blink.cmp (by means of blink-cmp-copilot). My main problem with
that is that then you cannot use an excellent feature of copilot which is "accept one word" or "accept one line".
You either accept the whole suggestion or nothing at all.

There is an [open issue](https://github.com/Saghen/blink.cmp/issues/1498) for this, and if/when it is fixed my
workaround will not be required. In the meantime, and after many experiments, I am settling with the following
setup:

- Use `copilot.lua` outside of `blink.cmp`
- Have a key that toggles between blink, copilot, or nothing.

That's basically it. However, some tricks were required in the [file](lua/plugins/blink_copilot_combined.lua):

- You cannot simply disable `blink-cmp-copilot`, because LazyVim adds some sources dependencies. Instead, I use an
  opts function that removes copilot from blink sources after the fact
- For `copilot.lua`, I redefine the `should_attach` function to look at my newly defined buffer variable.
  Otherwise, copilot is re-enabled even after I disable it.

A new key mapping (`Alt-Z`) toggles between 3 states: blink enabled (and copilot disabled), copilot enabled (and
blink disabled), or both disabled. The key works both in normal and insert mode so you can switch while typing.

And a new autocommand makes sure that you start each buffer in the status with both copilot and blink disabled.

I kept the keymap and autocommand in the `/lua/config/*` files.

### lualine

I left alone the default lualine sections (bottom of the window) and added extra information in the winbar (top
of the window), including an indicator of whether I am using blink, copilot, or none

But I left commented code on how to modify the lualine sections without overriding them.

### markdownlint-cli2

This tool can only be configured either by a file in the current directory or by explicitly passing a configuration file. To complicate things further, it turns out that this is called twice (once by `none-ls`, another by `nvim-lint`). I added 2 plugin files to reconfigure them so in both cases it uses the configuration in `.markdownlint-cli2.yaml` in nvim config folder.

### nvim-lspconfig

I find that the virtual text about diagnostics (specially now that I am experimenting with many of mason plugins) clutters the screen too much. This could be reconfigured in `options.lua` but I opted for reconfiguring nvim-lspconfig.

I then explore the diagnostics with `:Trouble diagnostics` (leader-xx) or `:FzfLua diagnosics_document` (leader-sd)

I also have disabled `harper_ls` at startup as it introduces too much noise. I can always reenable with my custom command (TODO: document it). Same applies for `vale_ls`

### conform debugging

I reconfigured conform debug level, at least while experiment with LSPs and formatters

### todo-comments

This plugin works by default in the current working directory. While some of the commands accept a `cwd` option, not all of them do. I initially created a fork of the plugin, but finally decided to have keymaps that temporarily switch the cwd, execute the command, and then switch back. I am unsure if this can create race conditions for other plugins, so use it at your own risk.

### luaconsole and neorepl

These are two plugins not part of LazyVim that I added for learning lua.

### codecompannion

A plugin not part of LazyVim that is similar to VSCode GitHub Copilot.

### mini-hipatterns

This plugin highlights strings such as TODO, FIXME, ... I added some patterns that I typically use to the default config.

### snacks

This plugins is responsible for multiple things. So far, I have only reconfigured the time that the disappearing messages remain on screen, as the default value was too small for my taste

## Miscellaneous information

No change in the environment, just some info I gathered:

### Distraction free modes

- zen mode (`<leader>uz`) for less distractions
- Zoom mode (`<leader>uZ`) is similar. One comes from folke, the other from snacks

### Useful keys to remember

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

### Local configs

`.lazy.lua` file at project level is loaded after all other plugins. For per-project configuration

BTW: if `exrc` option is set, then `.nvim.lua` is also sourced.

### trouble.nvim deepdive

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
  - [ ] add shortcut: symbols (LSP document symbols) to the right
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

### Brief description of plugins

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

neoconf: json files to ocnfigure LSP ???

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

nvim-treesitter: treesitter is a parser.

- Check status with :TSInstallInfo
- Install with :TSInstall language
- Update with :TSUpdate
- Uninstall with :TSUninstall language
- Use :TSModuleInfo list information about module state for each filetype
- :TSBufEnable and :TSBufDisable to enable/disable module on current buffer
- :TSEnable and :TSDisable to enable/disable module on every buffer. If filetype is specified, enable/disable only for this filetype.
- More help with :h nvim-treesitter-commands

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

trouble: leader-c and leader-x functions. also :Trouble

ts-comments: some auxiliary lib

vim-dadbod\*: database interface. command :DB or :DBUI or leader-D

vim-helm. Syntax for helm

vim-illuminate: highlight other uses of the word under the cursor. uses LSP

vim-startuptime: to profile startup time

vimtex: suport for Latex

which-key: Shows available keymaps

yanky: advanced yank: leader-p <p <P =p =P >p >P TODO: complete

### brief description of LSPs and other things installed with mason

- marksman offers completions (for blink) and an action to create table of contents for markdown


### concepts

- The location list is local to a window. Open it with :lopen or :lw
- The quickfix list is global. Open it with :copen or :cw
- Some plugins fill one of those lists, some fill the other

- The status line is what you see at the bottom of a window
- The winbar is similar but at the top of the window
- The tabline alows to select which buffer

## License

All code is licensed under the [MIT License](https://opensource.org/license/mit).
All text/content is dedicated to the public domain under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/).
