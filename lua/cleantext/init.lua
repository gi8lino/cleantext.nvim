--- CleanText.nvim - Automatically replaces typographic symbols on save.
-- This plugin replaces characters like smart quotes, long dashes, and ellipses
-- with simpler ASCII equivalents before saving a buffer.
-- Author: gi8lino <https://github.com/gi8lino>

local M = {}

-- Default replacements table.
-- Users can override or extend this via the `opts.replacements` table.
local default_replacements = {
	["“"] = '"',
	["”"] = '"',
	["‘"] = "'",
	["’"] = "'",
	["—"] = "--",
	["–"] = "-",
	["…"] = "...",
}

-- Tracks whether replacement is enabled
M.enabled = true

-- Active replacement table after merging with user opts
M.replacements = {}

--- Toggle automatic replacement on/off.
function M.toggle()
	M.enabled = not M.enabled
	print("CleanText " .. (M.enabled and "enabled" or "disabled"))
end

--- Return current status as a string (for statusline etc).
-- @return string "CleanText: ON" or "CleanText: OFF"
function M.status()
	return M.enabled and "CleanText: ON" or "CleanText: OFF"
end

--- Internal: replaces configured patterns in the current buffer.
-- This function runs automatically before saving (via autocommand).
function M.clean_buffer()
	if not M.enabled then
		return
	end

	local bufnr = vim.api.nvim_get_current_buf()

	-- Skip if buffer is readonly or not modifiable
	if vim.bo[bufnr].readonly or not vim.bo[bufnr].modifiable then
		return
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	for i, line in ipairs(lines) do
		for pattern, replacement in pairs(M.replacements) do
			-- Apply each replacement pattern to the line
			line = line:gsub(pattern, replacement)
		end
		lines[i] = line
	end

	-- Write modified lines back to buffer
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

--- Plugin setup function (called automatically by Lazy.nvim via `opts`).
-- @param opts table: user configuration
--   - replacements (table<string, string>): replacement rules
function M.setup(opts)
	opts = opts or {}

	-- Merge user replacements with defaults
	M.replacements = vim.tbl_extend("force", default_replacements, opts.replacements or {})

	-- Register autocommand to clean buffer before saving
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*",
		callback = M.clean_buffer,
		desc = "CleanText: replace smart characters before saving",
	})
end

return M
