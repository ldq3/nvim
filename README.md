插件管理使用 Neovim 0.12+ 内置的 `vim.pack`。整个配置刻意保持「一个文件只做一件事」的扁平结构。

## 目录树

```
~/.config/nvim
├── init.lua              # 入口：声明插件清单 + 加载各层配置
├── README.md             # 学习笔记（LSP 概念、手动启动 lsp 命令、信息流笔记）
├── STATUS.md             # 环境备忘（"有 npm 但没有 node"）
├── lua/
│   ├── info.lua          # 个人数据（Obsidian workspace 路径）
│   ├── visuals.lua       # 基础选项 + 主题 + 光标特效
│   ├── plugin/           # 每个插件一个配置文件 + 加载器
│   │   ├── mod.lua
│   │   └── heirline/     # 唯一带子模块的插件：mod/status/winbar/buffer
│   ├── ui/               # 快捷键与交互层
│   │   ├── mod.lua  file.lua  buffer.lua  tab.lua  language.lua  complete.lua
│   ├── language/         # 语言服务器（LSP）配置
│   │   ├── mod.lua  lua.lua  python.lua  haskell.lua  obsidian.lua
│   │   └── ts.lua  c.lua  rust.lua  lean.lua（均为空占位）
│   └── utils/            # 工具函数
│       ├── mod.lua       # keymap 批量注册、pcall 包装
│       └── find.lua      # 空文件（未使用）
```

## 启动流程

1. `init.lua` 用 `vim.pack.add` 一次性声明全部插件（按字母分组：A/C/D/E/F/G/H/L/M/N/O/P/R/S/T/W），带 `TODO` 标记的表示配置未完成（avante、overseer）。
2. 依次 `require` 四个层：
   - `plugin.mod` → `ui.mod` → `visuals` → `language.mod`
3. `plugin/mod.lua` 是自写的加载器 `load(conf)`：遍历插件名列表，若存在 `plugin/<名>/mod.lua` 就加载子模块（目前只有 heirline），否则直接 `require("plugin.<名>")`。此外单独 `require("lazygit")` 并加载 telescope 的 `telescope-tabs` 扩展。

## 各层职责

**plugin/**（插件配置，约 25 个文件）
- `nvim.lua`：编辑器选项（`laststatus=3`、conceal 等）与全局变量
- `nvim-cmp.lua`：补全源（lsp / luasnip / buffer / path / lazydev）、菜单样式、`: 命令行补全
- `mason*.lua` + `nvim-dap.lua` + `mason-nvim-dap.lua`：LSP/DAP 安装管理，debugpy 已配置，但 Python DAP 适配器代码整段被注释
- `nvim-tree.lua`：文件树，自定义 `M` 键「移动文件到指定目录并保留文件名」
- `heirline/`：手写 tabline / statusline / winbar，颜色从高亮组动态取色，winbar 与 nvim-navic 联动
- `edgy` 负责布局（左侧文件树 + Outline，底部 noice 消息面板，用 filter 排除浮动窗口）
- `avante.lua`：AI 插件，配置了 deepseek flash/pro 两个 provider、tavily 联网搜索、RAG 默认关闭
- 其余（telescope、trouble、outline、which-key、noice、todo-comments、diffview、tabflow、auto-save、overseer、telescope-tabs）多为精简 setup；auto-save 只在 git/obsidian 仓库里生效
- `tabflow` 与 `telescope-tabs` 做了联动：tabs 列表显示 tabflow 的自定义标签名

**ui/**（按键映射）
- 统一用 `utils.keymap(leader, mode, {...})` 批量注册，按组划分：`<leader>l` 语言/LSP、`<leader>f` 文件、`<leader>b` 缓冲区、`<leader>t` 标签页、`<leader>x` Trouble 面板
- `language.lua` 所有 LSP 操作都先检查 `vim.lsp.get_clients()`，无 LSP 时静默跳过
- `file.lua` 支持可视模式选中文本后直接 grep 搜索（含 rg 特殊字符转义）

**language/**（LSP）
- `mod.lua` 设置统一的 diagnostic 外观（圆角浮窗、不用 virtual text），并加载 lua / haskell / obsidian 三个语言模块，同时用 mason-tool-installer 保证 debugpy 安装
- `lua.lua` 配置 lua_ls（关闭 telemetry、ignoreDir、全局 `vim`/`require`）+ lazydev
- 使用新式 `vim.lsp.config` / `vim.lsp.enable` API

**其他**
- `visuals.lua`：4 空格、相对行号、`winborder=rounded`、catppuccin mocha 主题（自定义行号高亮）、smear-cursor 光标拖尾
- `info.lua`：集中存放个人路径，供 obsidian 模块引用

## 值得注意的现状

- `language/ts.lua`、`c.lua`、`rust.lua`、`lean.lua` 为空文件，`python.lua` 已写 pyright 配置但**未被 `language/mod.lua` require**（目前依赖 mason-lspconfig 的自动启用生效）。
- `python.lua` 之外的 ts/c/rust/lean 都还没接入加载器。
- `utils/find.lua`、`utils.mod.try()` 目前没有任何调用方。
- `plugin/mod.lua` 的列表里 `tabflow` 出现了两次（重复加载，无害）。
- 全局 `Cmp`、`Luasnip` 写成了全局变量（`nvim-cmp.lua` 首行）。
- 配置风格上中文注释与英文注释混用，文档仍属个人笔记性质。
