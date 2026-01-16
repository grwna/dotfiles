return {
  {
    "nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                jedi = {
                  extra_paths = { "/home/grwcha/grwna/usersettings/pyscripts" },
                },
              },
            },
          },
        },
      },
    },
  },
}
