-- 定义确保packer安装的函数
local ensure_packer = function()
	-- 获取Neovim函数模块
	local fn = vim.fn

	-- 设置packer安装路径（Neovim数据目录下的pack目录）
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

	-- 检查是否已安装（通过判断安装目录是否存在）
	if fn.empty(fn.glob(install_path)) > 0 then
		-- 如果未安装，则克隆仓库（使用git clone）
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		-- 加载新安装的packer
		vim.cmd([[packadd packer.nvim]])
		return true -- 返回需要引导的标志
	end
	return false
end

-- 执行安装检查，保存引导状态
-- BufWritePost事件是在缓冲区写入后触发，这里指定了文件名为plugins-setup.lua。
-- 当这个文件被保存后，会执行后面的命令。source <afile> 表示重新加载当前文件，
-- 也就是plugins-setup.lua，接着通过管道执行PackerSync命令。
-- PackerSync的作用是同步插件，即安装、更新或移除插件以匹配配置。
--这样，每次用户修改并保存plugins-setup.lua后，插件配置会自动更新，无需手动运行PackerSync。

local packer_bootstrap = ensure_packer()

-- 将自动命令定义移到Packer初始化之后
return require("packer").startup(function(use)
	-- 必须包含packer自身
	use("wbthomason/packer.nvim")
	use("folke/tokyonight.nvim")
	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({
		"smoka7/hop.nvim",
		tag = "*", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	})

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use({
		"williamboman/mason.nvim", -- in charge of managing lsp servers, linters & formatters
	})
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"glepnir/lspsaga.nvim",
		-- commit = "93b5b50", -- 指定稳定版本提交哈希
		config = function()
			require("lspsaga").setup({})
		end,
	}) -- enhanced lsp uis
	use({
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" }, -- 确保依赖声明
		config = function()
			require("trouble").setup({
				auto_preview = false, -- 根据 Reddit 建议关闭自动预览
				use_diagnostic_signs = true, -- 使用 LSP 诊断符号
			})
		end,
	})

	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	-- 用户插件声明区域（示例中被注释）
	-- use 'foo1/bar1.nvim'
	-- use 'foo2/bar2.nvim'

	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = vim.fn.expand("~/.config/nvim/lua/bryant/plugins-setup.lua"), -- 使用绝对路径
		callback = function()
			vim.cmd("luafile " .. vim.fn.expand("%:p")) -- 使用完整路径加载
			vim.schedule(function() -- 确保在合适时机执行
				require("packer").sync()
			end)
		end,
		group = vim.api.nvim_create_augroup("PackerAutoSync", { clear = true }),
	})

	use({
		"dhananjaylatkar/cscope_maps.nvim",
		config = function()
			require("cscope_maps").setup()
		end,
	})

	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
			vim.keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<CR>")
		end
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
