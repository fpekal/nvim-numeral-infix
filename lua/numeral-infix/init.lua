local M={}

local enabled = false
local mode = 'infixes'

function M.setup(opts)
  if opts.mode ~= nil then
	mode = opts.mode
  end

  if opts.enable then
	M.enable()
  end
end

function M.enable()
  enabled = true
  require("numeral-infix.display").init()

  vim.api.nvim_create_augroup("NumeralInfix", {clear=true})
  vim.api.nvim_create_autocmd({'BufWinEnter', 'BufEnter', 'BufReadPost', 'TextChanged', 'TextChangedI', 'CursorMoved', 'CursorMovedI', 'ModeChanged'}, {callback = M.update, group = "NumeralInfix"})

  M.update()
end

function M.disable()
  enabled = false
  require("numeral-infix.display").disable()

  vim.api.nvim_del_augroup_by_name("NumeralInfix")
end

function M.update()
  if enabled then
	local places = require("numeral-infix.detect").find_places_in_curr_buffer()
	if mode == 'infixes' then
	  require("numeral-infix.display").show_infixes_in_places(places)
	elseif mode == 'colors' then
	  require("numeral-infix.display").show_colors_in_places(places)
	end
  end
end

return M
