local opt = vim.opt

-- 行号设置 --
opt.number = true -- 显示绝对行号（左侧数字列）
opt.relativenumber = true -- 显示相对行号（光标所在行显示0，其他行显示与光标的距离）

-- 缩进设置 --
opt.tabstop = 4 -- 按 Tab 键时显示为 4 个空格宽度
opt.shiftwidth = 4 -- 使用 >> 或 << 进行缩进调整时，每次移动 4 个空格
opt.expandtab = true -- 将 Tab 键输入自动转换为空格（避免混合空格和制表符）
opt.autoindent = true -- 自动继承上一行的缩进（适合代码块结构）
