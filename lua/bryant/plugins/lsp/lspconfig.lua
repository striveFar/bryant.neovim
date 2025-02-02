-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	keymap.set("n", "<leader>s", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
	keymap.set("n", "<leader>d", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "<leader>g", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "<leader>ica", "<cmd>Lspsaga incoming_calls<CR>", opts) -- see incoming calls in window
	keymap.set("n", "<leader>oca", "<cmd>Lspsaga outgoing_calls<CR>", opts) -- see outgoing calls in window
	keymap.set("n", "<leader>i", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>r", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts) -- see outline on right hand side
	keymap.set("n", "<leader>tt", "<cmd>Lspsaga term_toggle<CR>", opts) -- toggle terminal

	-- typescript specific keymaps (e.g. rename file and update imports)
	-- if client.name == "tsserver" then
	--   keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
	--   keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
	--   keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	-- end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure cpp clangd
local clangd_args = { "clangd", "--header-insertion=never" }

-- 动态生成编译命令参数
local compile_commands_arg = (function()
	local cwd = vim.fn.getcwd()
	local compile_commands = cwd .. "/compile_commands.json"

	if vim.fn.filereadable(compile_commands) == 1 then
		return "--compile-commands-dir=" .. cwd
	end

	if vim.fn.expand("%:t") == "cscope.files" then
		return "--compile-commands-dir=" .. vim.fn.expand("%:p:h")
	end

	return nil
end)()

-- 如果有有效参数则添加
if compile_commands_arg then
	table.insert(clangd_args, compile_commands_arg)
	print("[Clangd] Using compile commands:", compile_commands_arg)
else
	-- print("[Clangd] No compile commands found in:", vim.fn.getcwd())
end

lspconfig["clangd"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = clangd_args, -- 使用预处理后的参数列表
})

-- configure pyright server
lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		pyright = {
			autoImportCompletion = true,
			python = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
				},
			},
		},
	},
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- 添加 LSP 启动日志（在文件顶部添加）
vim.lsp.set_log_level("debug") -- 开启详细日志

-- 修改 LSPSaga 配置
require("lspsaga").setup({
	outline = {
		win_position = "right",  -- 大纲窗口位置
		win_width = 40,          -- 窗口宽度
		auto_preview = false,    -- 关闭自动预览
		detail = true            -- 显示详细信息
	},
	-- 其他配置保持不变...
})

