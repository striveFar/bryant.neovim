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

## 快捷键指南

### 核心操作

### 快速跳转	
| 快捷键          | 模式 | 功能描述                     | 所属插件  |
|-----------------|------|----------------------------|----------|
| `<leader>hh`    | n    | 跨窗口跳转                 | Hop      |

### LSP 操作
| 快捷键          | 模式 | 功能描述                     | 所属插件  |
|-----------------|------|----------------------------|----------|
| `<leader>s`     | n    | 查找符号引用                | LSPSaga  |
| `<leader>d`     | n    | 跳转到声明                 | LSPSaga  |
| `<leader>g`     | n    | 预览定义                   | LSPSaga  |
| `<leader>a`     | n    | code action                | LSPSaga  |
| `<leader>r`     | n    | 重命名符号                 | LSPSaga  |
| `<leader>ld`    | n    | 行诊断信息                 | LSPSaga  |
| `<leader>cd`    | n    | 光标诊断信息               | LSPSaga  |
| `K`             | n    | 悬浮文档                   | LSPSaga  |
| `<leader>o`     | n    | 大纲视图                   | LSPSaga  |
| `<leader>tt`    | n    | 终端切换                   | LSPSaga  |
| `<leader>i`     | n    | 跳转到实现                 | LSPSaga  |
| `<leader>ica`   | n    | 查看入参                   | LSPSaga  |
| `<leader>oca`   | n    | 查看出参                   | LSPSaga  |
| `<leader>o`     | n    | 大纲视图                   | LSPSaga  |
| `<leader>tt`    | n    | 内置终端切换               | LSPSaga  |

### Cscope 操作
| 快捷键          | 模式 | 功能描述                     | 所属插件  |
|-----------------|------|----------------------------|----------|
| `<C-\>s`       | n    | 查找符号引用                | Cscope   |
| `<C-\>g`       | n    | 全局定义                   | Cscope   |
| `<C-\>c`       | n    | 查找调用                   | Cscope   |
| `<C-\>d`       | n    | 查找定义                   | Cscope   |
| `<C-\>t`       | n    | 查找文本                   | Cscope   |
| `<C-\>e`       | n    | 查找包含                   | Cscope   |
| `<C-\>f`       | n    | 查找函数                   | Cscope   |
| `<C-\>i`       | n    | 查找包含文件               | Cscope   |

### 诊断管理
| 快捷键          | 模式 | 功能描述                     | 所属插件  |
|-----------------|------|----------------------------|----------|
| `[d`           | n    | 上一个诊断                 | LSPSaga  |
| `]d`           | n    | 下一个诊断                 | LSPSaga  |
| `<leader>ld`    | n    | 行诊断信息                 | LSPSaga  |
| `<leader>cd`    | n    | 光标诊断信息               | LSPSaga  |
| `<leader>xx`    | n    | 切换诊断列表                 | Trouble  |
| `<leader>xw`     | n    | 工作区诊断                  | Trouble  |
| `<leader>xd`     | n    | 文档诊断                    | Trouble  |


### 工具集成
| 快捷键          | 模式 | 功能描述                     | 所属插件       |
|-----------------|------|----------------------------|---------------|
| `<leader>tt`    | n    | 终端切换                   | LSPSaga       |
| `<leader>xQ`    | n    | 快速修复列表               | Trouble       |
| `<leader>xL`    | n    | 位置列表                   | Trouble       |

## 文件树 (NvimTree)
| 模式 | 快捷键 | 功能描述               | 文件树专用模式 |
|------|--------|------------------------|----------------|
| n    | a      | 新建文件/目录          | 需确认类型     |
| n    | d      | 删除当前项             | 支持批量删除   |
| n    | r      | 重命名文件/目录        | 即时生效       |
| n    | gy     | 复制绝对路径           | 到系统剪贴板   |
| n    | v      | 垂直分屏打开           | 分屏编辑       |
| n    | u      | 返回上级目录           | 目录导航       |
| n    | <C-b>  | 打开/关闭文件树        | 文件树         |

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
│       │   ├── autocmds.lua
│       │   ├── colorscheme.lua
│       │   ├── keymaps.lua
│       │   └── options.lua
│       └── plugins/      # 插件配置
│           ├── lsp/
│           │   ├── lspconfig.lua
│           │   ├── mason.lua
│           │   └── null-ls.lua
│           └── nvim-cmp.lua
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

B:
Q: nvim 图标乱码？

1. 安装 nerd font 字体: https://www.nerdfonts.com/font-downloads
```bash
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
&& cd ~/.local/share/fonts \
&& unzip JetBrainsMono.zip \
&& rm JetBrainsMono.zip \
&& fc-cache -fv
```
2. 如果是WSL2， 请使用windows terminal 配置

https://learn.microsoft.com/zh-cn/windows/terminal/install

参考视频：
https://www.bilibili.com/video/BV15T4y1r7TY/?spm_id_from=333.337.search-card.all.click&vd_source=6102e5b6d40bb19fdbdc01d2930deec8

C:
Q: LSP: pyright 安装失败

![image](https://github.com/user-attachments/assets/ed8a0763-43be-49ba-8210-ce28fe0fb958)

![image](https://github.com/user-attachments/assets/4f71e1b7-da75-4a42-b755-d47534377ff0)

将bin目录放入系统环境变量中

> 个人配置，参考了B站大佬的配置，传送门：[从0带你入门Vim](https://www.bilibili.com/video/BV1zY4y1Z7FR/?vd_source=6102e5b6d40bb19fdbdc01d2930deec8)

欢迎提交 Issue 反馈问题
