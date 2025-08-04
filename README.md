# My nvim config

While experimenting with neovim, I am tweaking the configuration. This repository will over time accumulate my customizations in the hope that it can help others facing my same problems.

## My setup

I am using [LazyVim](https://www.lazyvim.org/) as the base, so the intial structure is that of the [starter](https://github.com/LazyVim/starter)

The config goes under `~/.config/nvim`. But I was accustomed to my configuration being in `~/.vim` so I created a symbolic link from `~/.nvim` to `~/.config/nvim`

## Changes in `./lua/config/lazy.lua`

I like to know about new plugin versions, so I have set `lazy.checker.notify = true` in `./lua/config/lazy.lua`.
But once per day is enough, so I have set `lazy.checker.frequency = 86400`. You can always force a check by running `:Lazy update`.

## Legacy vimscript config

In [init.lua](init.lua) you can see (commented out) how to include [legacy vimscript](legacy.vim) configuration files. I used it initially for some key mappins that I converted since then into lua.

## License

All code is licensed under the [MIT License](https://opensource.org/license/mit).
All text/content is dedicated to the public domain under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/).
