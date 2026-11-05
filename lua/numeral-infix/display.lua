local M={}

local ns

local function set_colors()
  vim.api.nvim_set_hl(0, "NumeralInfixK", {link="GruvboxRed"})
  vim.api.nvim_set_hl(0, "NumeralInfixM", {link="GruvboxOrange"})
  vim.api.nvim_set_hl(0, "NumeralInfixB", {link="GruvboxYellowSign"})
  vim.api.nvim_set_hl(0, "NumeralInfixT", {link="GruvboxGreenSign"})
end

function M.init()
  ns = vim.api.nvim_create_namespace("NumeralInfix")
  set_colors()
end

function M.disable()
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

function M.show_infixes_in_places(places)
  if ns == nil then
	return
  end
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

  for _,place in ipairs(places) do
	vim.api.nvim_buf_set_extmark(0, ns, place.y-1, place.x, {virt_text={{place.kind, "NumeralInfix"..place.kind}}, virt_text_pos="inline"})
  end
end

function M.show_colors_in_places(places)
  if ns == nil then
	return
  end
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

  for _,place in ipairs(places) do
	vim.api.nvim_buf_set_extmark(0, ns, place.y-1, place.x-1, {hl_group="NumeralInfix"..place.kind, hl_mode="combine", end_col=place.x})
  end
end

return M
