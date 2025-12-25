return {
  'TrevorS/uuid-nvim',
  lazy = true,
  config = function()
    -- optional configuration
    require('uuid-nvim').setup {
      case = 'lower',
    }
  end,
}
