# Contributing to nvim-svelte-snippets

Thank you for considering contributing to this project! Here's how to get started with development.

## Development Setup

To develop and test the plugin locally:

1. Clone the repository:

```bash
git clone https://github.com/nvim-svelte/nvim-svelte-snippets ~/YOUR_LOCAL_DEV_FOLDER/nvim-svelte-snippets
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

## Development Workflow

### Adding New Snippets

#### Svelte Template Snippets

To add new Svelte template snippets, edit `lua/nvim-svelte-snippets/svelte.lua` and add a new entry to the `svelte_blocks` table:

```lua
{
  trigger = "your-trigger",
  description = "Your snippet description",
  format = [[
{{#your-block {}}}
    {}
{{/your-block}}
  ]],
  nodes = {
    utils.i(1, "first_placeholder"),
    utils.i(2, "second_placeholder"),
  }
},
```

#### TypeScript Snippets

To add new TypeScript snippets, edit `lua/nvim-svelte-snippets/typescript.lua` and add a new entry to the `typescript_snippets` table:

```lua
{
  trigger = "your-trigger",
  description = "Your snippet description",
  format = [[
// Your TypeScript snippet here
function yourFunction({}) {
  {}
}
  ]],
  nodes = {
    ls.insert_node(1, "param"),
    ls.insert_node(2, "// your code here"),
  }
},
```

### Testing

Make sure to test your snippets in both:

- Standalone Svelte files
- SvelteKit project files

### Documentation

When adding new snippets, remember to update the README.md with the new snippet trigger and description.

## Pull Request Process

1. Create a feature branch for your changes
2. Make your changes and test thoroughly
3. Update documentation if necessary
4. Submit a pull request with a clear description of the changes
