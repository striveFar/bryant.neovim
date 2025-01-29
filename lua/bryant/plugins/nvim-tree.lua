--[[
	nvim-tree 是一个文件浏览器插件，用于在 Neovim 中浏览和管理文件系统。
	它提供了树状结构视图，支持文件和目录的浏览、搜索、过滤、重命名、删除等操作。
	nvim-tree 还支持插件集成，如 Git 状态显示、文件图标、自定义快捷键等。
	通过使用 nvim-tree，用户可以更高效地导航和管理项目文件，提升开发效率。
]]
--加载一个不存在的模块或者加载的模块有语法错误会直接中止当前正在执行的脚本。pcall() 函数可以用来处理这类错误
local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
	return
end


-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- OR setup with some options
nvim_tree.setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    -- adaptive_size = true,  -- 该选项在新版本中可能已弃用
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- 文件树内部快捷键
    vim.keymap.set("n", "a",              api.fs.create,                      opts("Create File Or Directory"))
    vim.keymap.set("n", "d",              api.fs.remove,                      opts("Delete"))
    vim.keymap.set("n", "r",              api.fs.rename,                      opts("Rename"))
    vim.keymap.set("n", "gy",             api.fs.copy.absolute_path,          opts("Copy Absolute Path"))
    vim.keymap.set("n", "q",              api.tree.close,                     opts("Close"))
    vim.keymap.set("n", "?",              api.tree.toggle_help,               opts("Help"))
    vim.keymap.set("n", "<CR>",           api.node.open.edit,                 opts("Open"))
    vim.keymap.set("n", "o",              api.node.open.edit,                 opts("Open"))
    vim.keymap.set('n', '<C-b>',          api.tree.toggle,                    opts('Toggle'))
    vim.keymap.set('n', 'u',              api.tree.change_root_to_parent,     opts('Up'))
    vim.keymap.set('n', 'v',              api.node.open.vertical,             opts('Vertical Split'))
  end,
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

