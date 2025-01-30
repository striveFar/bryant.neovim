local t_status, trouble = pcall(require, "trouble")
if not t_status then
	vim.notify("Trouble.nvim not installed!", vim.log.levels.WARN)
	return
end

trouble.setup({
	auto_open = false, -- 不要自动打开
	auto_close = true, -- 自动关闭
	use_diagnostic_signs = true, -- 使用 LSP 诊断符号
})
