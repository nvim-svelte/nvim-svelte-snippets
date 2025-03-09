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
        prefix = "kit"       -- Prefix for TypeScript snippets (e.g., kit-load)
    }
}
```

## How It Works

When enabled, the plugin:

- Always loads Svelte snippets for `.svelte` files in any project
- Only loads TypeScript snippets for `.ts` files in SvelteKit projects (when `auto_detect` is true)
- Can be configured to load TypeScript snippets in any project by setting `auto_detect` to false

### Load Functions

https://github.com/user-attachments/assets/1e475ee6-d00d-4360-ba2b-3254bd8c1c3b

### Configuration Options

- `enabled`: Enable or disable all snippets globally (default: `true`)
- `auto_detect`: When true, only loads SvelteKit TypeScript snippets in detected SvelteKit projects (default: `true`). Svelte snippets for `.svelte` files are always loaded regardless of this setting.
- `prefix`: Add prefix to TypeScript snippets (default: `"kit"`)

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

### TypeScript Snippets (SvelteKit route files)

All TypeScript snippets use the prefix configured in your settings (default: `kit-`)

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

Contributions are welcome! See the [CONTRIBUTING.md](CONTRIBUTING.md) file for development instructions.

## License

MIT
