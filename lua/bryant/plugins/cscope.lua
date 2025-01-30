-- 检查插件是否加载成功
local status, cscope = pcall(require, "cscope_maps")
if not status then
    return
end

-- 初始化配置（使用默认配置）
cscope.setup({
  prefix = "<C-\\>", -- 修改触发键为 Ctrl+\
  -- 自动使用光标下的符号
  skip_picker_for_single_result = true, -- 单个结果直接跳转
  skip_input_prompt = true,  -- 跳过输入提示
}) 