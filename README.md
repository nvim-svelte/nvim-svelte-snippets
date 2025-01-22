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
    "nvim-svelte/nvim-svelte-snippets",
    dependencies = "L3MON4D3/LuaSnip",
    opts = {
        -- your configuration comes here
        -- or leave empty for defaults
    }
}
```

## Configuration

You can configure the plugin by passing options to the setup function:

```lua
{
    "nvim-svelte/nvim-svelte-snippets",
    dependencies = "L3MON4D3/LuaSnip",
    opts = {
        enabled = true,      -- Enable/disable snippets globally
        auto_detect = true,  -- Only load in SvelteKit projects
        prefix = "sk"        -- Prefix for TypeScript snippets (e.g., sk_load)
    }
}
```

### Configuration Options

- `enabled`: Enable or disable snippets globally (default: `true`)
- `auto_detect`: Only load snippets in detected SvelteKit projects (default: `true`)
- `prefix`: Add prefix to TypeScript snippets (default: `"sk"`)

### Commands

- `:ToggleSvelteKitSnippets` - Toggle SvelteKit snippets on/off in TypeScript files

## Available Snippets

### Svelte Snippets (.svelte files)

- `page`: Creates a new SvelteKit page component
- `each`: Creates a Svelte each block

### TypeScript Snippets (+page.ts/+page.server.ts)

- `sk-load`: Creates a client-side load function
- `sk-sload`: Creates a server-side load function
- `sk-actions`: Creates form actions template

## Keybindings

Default LuaSnip keybindings for navigating snippets:

- `<Tab>`: Jump forward to next snippet position
- `<S-Tab>`: Jump backward to previous snippet position
- `<C-n>`: Next choice in choice node
- `<C-p>`: Previous choice in choice node

## Development

To develop and test the plugin locally:

1. Clone the repository:

```bash
git clone https://github.com/nvim-svelte/nvim-svelte-snippets ~/projects/nvim-svelte-snippets
```

2. Add the local plugin to your Neovim config (in your lazy.nvim plugins setup):

```lua
{
    dir = "~/YOUR_LOCAL_DEV_FOLDER/nvim-svelte-snippets",
    dependencies = "L3MON4D3/LuaSnip",
    opts = {},
    dev = true
}
```

3. Reload the plugin after making changes:
   - Save your changes
   - In Neovim, run: `:Lazy reload nvim-svelte-snippets`
   - Test in a .svelte file

## License

MIT
