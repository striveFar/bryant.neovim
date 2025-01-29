local status, tn = pcall(require, "tokyonight")
if not status then
	return
end

tn.setup({
	style = "storm",
	dim_inactive = true,
})

vim.cmd[[colorscheme tokyonight-storm]]
