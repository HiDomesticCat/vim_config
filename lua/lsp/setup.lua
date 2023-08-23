local lspconfig = require("lspconfig")

local servers = {
	pyright = require("lsp/config/pyright"),
	rust_analyzer = require("lsp/config/rust"),
	clangd = require("lsp/config/clangd"),
}
for name, config in pairs(servers) do
  -- 使用默认参数
  lspconfig[name].setup({})
end
