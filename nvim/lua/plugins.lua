vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'gennaro-tedesco/nvim-peekup'
end)
