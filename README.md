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

TODO: expand this section

## License

All code is licensed under the [MIT License](https://opensource.org/license/mit).
All text/content is dedicated to the public domain under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/).
