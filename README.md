# My NeoVim config

While experimenting with NeoVim, I am tweaking the configuration. This repository will over time accumulate my customizations in the hope that it can help others facing my same problems.

## My setup

I am using [LazyVim](https://www.lazyvim.org/) as the base, so the initial structure is that of the [starter](https://github.com/LazyVim/starter)

The config goes under `~/.config/nvim`. But I was accustomed to my configuration being in `~/.vim` so I created a symbolic link from `~/.nvim` to `~/.config/nvim`

## Changes in `./lua/config/lazy.lua`

I like to know about new plugin versions, so I have set `lazy.checker.notify = true` in `./lua/config/lazy.lua`.
But once per day is enough, so I have set `lazy.checker.frequency = 86400`. You can always force a check by running `:Lazy update`.

## Legacy Vimscript config

In [init.lua](init.lua) you can see (commented out) how to include [legacy Vimscript](legacy.vim) configuration files. I used it initially for some key mappings that I converted since then into lua.

## Other config changes

Inside `lua/config` there are 3 files than you can tweak. AFAIK, it really doesn't matter in which file you put your changes, but I try to follow the suggested convention:

- `autocommands.lua` for autocommands
- `keymaps.lua` for key mappings
- `options.lua` for changing options

### autocommands.lua

Call me paranoid, but I don't like my passwords to be sent to copilot. An autocommand here sets a special filetype `passtxt` for any file containing the string `pass` in its name (you can always change that manually with `:set filetype=whatever`).

This is complemented later with an option to disable copilot for that filetype

### keymaps.lua

The default settings use left/right arrows to navigate the command line completion. This is unintuitive for me, as the possible completions are laid out vertically, so I prefer to use up/down arrows. The file includes this change.

I also create shortcuts for my experimental plugin `chitshit`.

When adding new keymaps, or selecting keys for finetuning other plugins, you need 2 things:

1. Knowing if some key is going to conflict with something else. For that you can do `:help insert-index` (or similar) to know the builtin keys, and which-key or chitshit to know additions form plugins
2. But you also need to know how to send those keys. For example in a Spanish keyboard, the `[` is obtained by pressing `AltGr + <the key containing [>`. So a combinations like `<M-[>` is impossible because (Becasue "meta" is "alt", at least in my PC).

So I have created a debug tool (triggered in normal mode with `<leader><leasder>cx`) that prints what Vim sees when you press keys. You exit it by pressing x. With this I discovered some things interesting for me (your results may be totally different):

- Some keypresses didn't *reach* vim because they were captured by Windows Terminal ( I run NeoVim under WSL). But I was never going to use those Windows Terminal features and could remove them from Windows Terminal config and make them available for VIM
- Some of the keys didn't work as expected. E.g ctrl+1 sends `1`, not `<C-1>`, ctrl+2 sends `<C-space>`, ... Fortunately, among these quirks I found that I can achieve `<C-]` by pressing ctrl+5, or `<C-\>` by pressing ctrl+`<`. Some of those would have been difficult or impossible otherwise in my keyboard
- The numbering of function keys is strange:
  - plain function keys generate `<F-1>` to `<F-12>`
  - with shift they generate `<F13>` to `<F24>`
  - with ctrl they generate `<F25>` to `<F36>`
  - with shift and control they generate `<F37>` to `<F48>`
  - with alt (meta) they generate `<F49>` to `<F60>`
  - and with shift and alt they generate `<F61>` to `<F72>`
  - .... But then with control+alt the generated key is `<M-C-F1>` to `<M-C-F12>`
  - and with shift+control+alt it is `<M-C-S-F1>` to `<M-C-S-F12>`

### options.lua

- Here is where I tell copilot to skip the files with the `passtxt` filetype that I created in autocommands.
- paths for the python provider
- disable unused providers
- some personal preferences related to how I like to see things displayed
- leader keys comfortable for me in a Spanish keyboard

## Plugins

File [lazyvim.json](lazyvim.json) defines the extra plugins that you want to use. But it is much easier to modify that with the `LazyExtras` menu from inside NeoVim.

For other plugins, you create files under `lua/plugins`.

You may want to put files under `lua/plugins` for the following reasons:

- To add some plugin that is not contemplated by LazyVim (not even with LazyExtras)
- To modify the default configuration of a plugin that LazyVim provides
- To disable a plugin that LazyVim provides by default (by setting `enabled = false`)

Files in that folder are only loaded in they end in `.lua`. You can therefore keep files with other names like `.lua.no` so you can activate by simply renaming them.

### noice (bring back the command line)

I am a long time user of Vim, so my "muscle memory" is used to the command line at the bottom of the screen. This managed by the noice plugin, and I created a [file](lua/plugins/noice.lua) to revert back to old behavior.

### tokyonight (colors)

I am too lazy to explore and decide on color schemes, so I am using the default one provided by LazyVim, which is tokyonight. But there were some things that I had to tweak:

- The line between splits (that you can drag with the mouse to resize) was almos imposible to find.
- The ghost text that copilot+blink provides was too dark for my tast.

So I created a [file](lua/plugins/tokyonight.lua) to tweak the colors.

### which-key

I love this plugin, with only one small "but": If the pop-up is too long, then to scroll through it you need to use some keys (that appear documented at the bottom of the pop-up) . By default these scrolling keys are CTRL+U and CTRL+D. I tried to map to up/down arrows and quickly found a problem: they did not work as expected because those keys by themselves are already used outside which-key. I ended up using Shift+Up and Shift+Down as a second best option. I created a [file](lua/plugins/which-key.lua) to do that.

In that file, I also added a keymap (ctrl+alt+w) to activate which-key in insert mode.

### chitshit (example of locally developed plugin)

This is my own plugin, and I am using it to learn about plugins, lua, ...
The interesting part are lines 2 and 3. By commenting one or the other, you can easily switch between a local copy and the one on github. I switch to local, do some development, and once finished I `git push`, switch back to github version, refresh (`U` in `:Lazy` screen) and check that it still works.

## License

All code is licensed under the [MIT License](https://opensource.org/license/mit).
All text/content is dedicated to the public domain under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/).
