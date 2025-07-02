local M = {}

-- Default replacement table
local default_replacements = {
	["“"] = '"',
	["”"] = '"',
	["‘"] = "'",
	["’"] = "'",
	["—"] = "--",
	["–"] = "-",
	["…"] = "...",
}

M.replacements = {}
M.enabled = true

--- Toggle on/off
function M.toggle()
	M.enabled = not M.enabled
	print("CleanText " .. (M.enabled and "enabled" or "disabled"))
end

--- Get status for statusline
function M.status()
	return M.enabled and "CleanText: ON" or "CleanText: OFF"
end

--- Run replacements on buffer before save
function M.clean_buffer()
	if not M.enabled then
		return
	end

	local bufnr = vim.api.nvim_get_current_buf()
	if vim.bo[bufnr].readonly or not vim.bo[bufnr].modifiable then
		return
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	for i, line in ipairs(lines) do
		for pattern, replacement in pairs(M.replacements) do
			line = line:gsub(pattern, replacement)
		end
		lines[i] = line
	end

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

--- Setup plugin
---@param opts? { replacements?: table<string, string> }
function M.setup(opts)
	opts = opts or {}
	M.replacements = vim.tbl_extend("force", default_replacements, opts.replacements or {})

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*",
		callback = M.clean_buffer,
		desc = "Clean smart characters before saving",
	})
end

M.setup() -- 🪄 Automatically call setup() with defaults on load

return M
