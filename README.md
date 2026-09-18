语言服务器协议（Language Server Protocol, LSP）

客户端是编辑器，服务端是一个后台进程。

查看插件源码路径：`lua vim.print(vim.pack.get())`

手动开启 lsp: `lua vim.lsp.start({name="lua_ls",cmd={"lua-language-server"},root_dir=vim.fn.stdpath("config"),settings={Lua={runtime={version="LuaJIT"},diagnostics={globals={"vim"}},workspace={checkThirdParty=false},telemetry={enable=false}}}})`


# AI


