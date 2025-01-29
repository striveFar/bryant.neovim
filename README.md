# YoungFar's Neovim 配置手册

## 核心特性
- 🚀 极简高效配置
- 🎨 TokyoNight 主题配色
- ⌨️ 符合直觉的快捷键设计
- 📦 模块化插件管理
- 🔍 单词跳转
## 安装说明

```bash
git clone https://github.com/striveFar/bryant.neovim.git ~/.config/nvim
```

## 核心快捷键
| 模式 | 快捷键       | 功能描述                 | 备注               |
|------|--------------|--------------------------|--------------------|
| i    | `jk`         | 退出插入模式             | 快速返回普通模式   |
| n    | `<C-b>`      | 切换文件树               | NvimTree插件       |
| n    | `<leader>hh` | 跨窗口单词跳转           | Hop插件            |
| n    | `<leader>w`  | 保存文件                 | 安全写入           |

## 文件树 (NvimTree)
| 模式 | 快捷键 | 功能描述               | 文件树专用模式 |
|------|--------|------------------------|----------------|
| n    | a      | 新建文件/目录          | 需确认类型     |
| n    | d      | 删除当前项             | 支持批量删除   |
| n    | r      | 重命名文件/目录        | 即时生效       |
| n    | gy     | 复制绝对路径           | 到系统剪贴板   |
| n    | v      | 垂直分屏打开           | 分屏编辑       |
| n    | u      | 返回上级目录           | 目录导航       |

## 插件列表
| 插件名称             | 功能描述                   | 文档链接                          |
|----------------------|----------------------------|-----------------------------------|
| packer.nvim          | 插件管理器                 | https://github.com/wbthomason/packer.nvim |
| nvim-tree.lua        | 文件树管理                 | https://github.com/nvim-tree/nvim-tree.lua |
| hop.nvim             | 快速跳转                   | https://github.com/smoka7/hop.nvim |
| which-key.nvim       | 快捷键提示                 | https://github.com/folke/which-key.nvim |

## 配置目录结构

```
~/.config/nvim/
├── lua
│   └── bryant
│       ├── core/         # 核心配置
│       │   ├── keymaps.lua
│       │   ├── options.lua
│       │   └── colorscheme.lua
│       └── plugins/      # 插件配置
│           ├── nvim-tree.lua
│           └── ...
└── init.lua              # 入口文件
```

## 主题配置
使用 TokyoNight Storm 主题：
```lua
-- 自动安装主题插件
require('tokyonight').setup({
  style = "storm",
  dim_inactive = true  -- 非活动窗口降低亮度
})
```

## 常见问题
Q: 快捷键不生效怎么办？

A: 
1. 确认插件安装完成 `:PackerStatus`

2. 检查键位冲突 `:verbose map <快捷键>`


Q: 如何更新配置？

```bash
# 每次保存配置文件后自动同步插件
vim.api.nvim_create_autocmd('BufWritePost', {
		pattern = vim.fn.expand('~/.config/nvim/lua/bryant/plugins-setup.lua'), -- 使用绝对路径
		callback = function()
			vim.cmd('luafile ' .. vim.fn.expand('%:p'))  -- 使用完整路径加载
			vim.schedule(function()  -- 确保在合适时机执行
				require('packer').sync()
			end)
		end,
		group = vim.api.nvim_create_augroup('PackerAutoSync', { clear = true })
	})
```


```bash
# 或在Neovim中手动执行
:PackerSync
:source ~/.config/nvim/init.lua
```

> 个人配置，参考了B站大佬的配置，传送门：[从0带你入门Vim](https://www.bilibili.com/video/BV1zY4y1Z7FR/?vd_source=6102e5b6d40bb19fdbdc01d2930deec8)

欢迎提交 Issue 反馈问题
