local opt = vim.opt

opt.number = true          -- 显示绝对行号
opt.relativenumber = true  -- 显示相对行号（相对于光标位置）

opt.tabstop = 4           -- 设置制表符宽度为4个空格
opt.shiftwidth = 4        -- 设置自动缩进宽度为4个空格
opt.expandtab = true      -- 将制表符替换为空格
opt.autoindent = true     -- 自动缩进