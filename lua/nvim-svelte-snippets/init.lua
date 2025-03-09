local M = {}

-- Default configuration
M.config = {
	enabled = true,
	auto_detect = true,
	prefix = "kit",
}

-- Check if we're in a SvelteKit project
local function is_sveltekit_project()
	local function file_exists(file)
		local f = io.open(file, "r")
		if f then
			f:close()
			return true
		end
		return false
	end

	-- Check package.json for @sveltejs/kit
	local package_json_exists = file_exists("package.json")
	if package_json_exists then
		local f = io.open("package.json", "r")
		if f then
			local content = f:read("*all")
			f:close()
			if content and content:find("@sveltejs/kit") then
				return true
			end
		end
	end

	-- Check for svelte.config.js
	if file_exists("svelte.config.js") then
		return true
	end

	-- Check for src/routes directory
	local handle = io.popen("test -d src/routes && echo true || echo false")
	if handle then
		local result = handle:read("*a")
		handle:close()
		if result then
			return result:match("true") ~= nil
		end
	end

	return false
end

-- Load Svelte snippets (for .svelte files)
local function load_svelte_snippets()
	require("nvim-svelte-snippets.svelte").setup()
end

-- Load TypeScript snippets (for SvelteKit functionality)
local function load_sveltekit_snippets(config)
	require("nvim-svelte-snippets.typescript").setup(config)
end

function M.setup(opts)
	-- Merge user config with defaults
	if opts then
		M.config = vim.tbl_deep_extend("force", M.config, opts)
	end

	-- Create the toggle command
	vim.api.nvim_create_user_command("ToggleSvelteKitSnippets", function()
		M.config.enabled = not M.config.enabled
		vim.notify("SvelteKit snippets " .. (M.config.enabled and "enabled" or "disabled"))
		-- Reload snippets with new state
		M.reload_snippets()
	end, {})

	-- Always load Svelte snippets if enabled
	if M.config.enabled then
		load_svelte_snippets()
	end

	-- Only load SvelteKit-specific snippets if enabled and
	-- (auto_detect is off or we're in a SvelteKit project)
	if M.config.enabled and (not M.config.auto_detect or is_sveltekit_project()) then
		load_sveltekit_snippets(M.config)
	end
end

function M.reload_snippets()
	-- Always reload Svelte snippets if enabled
	if M.config.enabled then
		load_svelte_snippets()
	end

	-- Only reload SvelteKit-specific snippets if enabled and
	-- (auto_detect is off or we're in a SvelteKit project)
	if M.config.enabled and (not M.config.auto_detect or is_sveltekit_project()) then
		load_sveltekit_snippets(M.config)
	end
end

return M
