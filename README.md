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

## License

All code is licensed under the [MIT License](https://opensource.org/license/mit).
All text/content is dedicated to the public domain under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/).
