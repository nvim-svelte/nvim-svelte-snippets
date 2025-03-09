# Svelte Snippets for Neovim

A collection of useful snippets for Svelte(Kit) development in Neovim using LuaSnip with TypeScript support.

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
        prefix = "kit"        -- Prefix for TypeScript snippets (e.g., kit-load)
    }
}
```

### Configuration Options

- `enabled`: Enable or disable snippets globally (default: `true`)
- `auto_detect`: Only load SvelteKit-specific TypeScript snippets in detected SvelteKit projects (default: `true`). Svelte snippets are always loaded for `.svelte` files regardless of this setting.
- `prefix`: Add prefix to TypeScript snippets (default: `"sk"`)

### Commands

- `:ToggleSvelteKitSnippets` - Toggle SvelteKit snippets on/off in TypeScript files

## Available Snippets

### Svelte Snippets (.svelte files)

| Trigger      | Description                                      |
| ------------ | ------------------------------------------------ |
| `page`       | Creates a new SvelteKit page component           |
| `if`         | Creates a Svelte if block                        |
| `each`       | Creates a Svelte each block                      |
| `await`      | Creates a complete Svelte await block            |
| `await-then` | Creates a Svelte await block with then shorthand |
| `key`        | Creates a Svelte key block                       |
| `snippet`    | Creates a Svelte snippet block (Svelte 5)        |

### TypeScript Snippets (+page.ts/+page.server.ts)

All TypeScript snippets use the prefix configured in your settings (default: `sk-`)

| Trigger             | Description                                          |
| ------------------- | ---------------------------------------------------- |
| `kit-load`          | Creates a load function with type choices            |
| `kit-actions`       | Creates form actions template                        |
| `kit-endpoint`      | Creates an endpoint handler with HTTP method choices |
| `kit-param-matcher` | Creates a param matcher                              |

## Keybindings

Default LuaSnip keybindings for navigating snippets:

- `<Tab>`: Jump forward to next snippet position
- `<S-Tab>`: Jump backward to previous snippet position

## Contributing

Contributions are welcome! Feel free to submit a PR to add more snippets or improve existing ones.

## License

MIT
