local M={}

local re_number = vim.regex("\\d\\+")
local re_K = vim.regex("\\d\\+\\d\\{3\\}")
local re_M = vim.regex("\\d\\+\\d\\{6\\}")
local re_B = vim.regex("\\d\\+\\d\\{9\\}")
local re_T = vim.regex("\\d\\+\\d\\{12\\}")

function M.find_places_in_curr_buffer()
  local ret={}
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  for line_num,line in ipairs(lines) do
	-- match_str can return only one string per call, so this variable tracks
	-- where the next search of a number in current line should start
	local start_col=1

	while true do
	  local line_sub = line:sub(start_col)
	  local match_start, match_end = re_number:match_str(line_sub)

	  if match_start == nil then
	  	break
	  end

	  local number = line_sub:sub(match_start+1, match_end)

	  local _,K_end = re_K:match_str(number)
	  if K_end ~= nil then
		table.insert(ret, {x=start_col+match_start+K_end-3-1, y=line_num, kind='K'})
	  end

	  local _,M_end = re_M:match_str(number)
	  if M_end ~= nil then
		table.insert(ret, {x=start_col+match_start+M_end-6-1, y=line_num, kind='M'})
	  end

	  local _,B_end = re_B:match_str(number)
	  if B_end ~= nil then
		table.insert(ret, {x=start_col+match_start+B_end-9-1, y=line_num, kind='B'})
	  end

	  local _,T_end = re_T:match_str(number)
	  if T_end ~= nil then
		table.insert(ret, {x=start_col+match_start+T_end-12-1, y=line_num, kind='T'})
	  end

	  start_col = start_col + match_end
	end
  end

  return ret
end

return M
