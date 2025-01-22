# Svelte Snippets for Neovim

A collection of useful snippets for Svelte(Kit) development in Neovim using LuaSnip with TypeScript syntax.

## Prerequisites

- Neovim >= 0.9.0
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "nvim-svelte/svelte-snippets.nvim",
    dependencies = "L3MON4D3/LuaSnip",
    opts = {}
}
```

## Development

To develop and test the plugin locally:

1. Clone the repository:

```bash
git clone https://github.com/nvim-svelte/svelte-snippets.nvim ~/projects/svelte-snippets.nvim
```

2. Add the local plugin to your Neovim config (in your lazy.nvim plugins setup):

```lua
{
    dir = "~/YOUR_LOCAL_DEV_FOLDER/svelte-snippets.nvim",
    dependencies = "L3MON4D3/LuaSnip",
    opts = {},
    dev = true
}
```

3. Reload the plugin after making changes:
   - Save your changes
   - In Neovim, run: `:Lazy reload svelte-snippets.nvim`
   - Test in a .svelte file

## Available Snippets

- `page`: Creates a new SvelteKit page component
- `load`: Creates a load function (with choice of PageLoad or PageServerLoad)
- `actions`: Creates form actions template
- `each`: Creates a Svelte each block

## Keybindings

Default LuaSnip keybindings for navigating snippets:

- `<Tab>`: Jump forward to next snippet position
- `<S-Tab>`: Jump backward to previous snippet position
- `<C-n>`: Next choice in choice node
- `<C-p>`: Previous choice in choice node

## License

MIT
