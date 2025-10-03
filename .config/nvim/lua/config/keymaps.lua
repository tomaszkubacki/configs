-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = LazyVim.safe_keymap_set

map("n", "<leader>tp", "yy<C-w>j <C-\\><C-N>pi", { desc = "paste in bottom terminal" })

map("n", "<leader>le", function()
  local line = vim.fn.getline(".")
  local output = vim.fn.system(line)
  vim.notify(output, vim.log.levels.INFO)
end, { desc = "Execute Line as Shell Command" })

function typewriter_reg(reg)
  local text = vim.fn.getreg(reg)
  typewriter(text)
end

function typewriter(keys, mode, escape_csi, delay_ms)
  mode = mode or "n"
  escape_csi = escape_csi or false
  delay_ms = delay_ms or 100

  local i = 1
  local len = #keys
  local timer = vim.loop.new_timer()
  vim.cmd("startinsert")
  timer:start(0, delay_ms, function()
    if i > len then
      timer:stop()
      timer:close()
      return
    end
    local char = keys:sub(i, i)
    vim.schedule(function()
      vim.api.nvim_feedkeys(char, mode, escape_csi)
    end)
    i = i + 1
  end)
end

function execute_selection()
  -- Yank the current line into the default register
  vim.cmd('normal! ""yy')
  local text = vim.fn.getreg('"')

  local snacks_terminal = require("snacks.terminal")
  local terminal = snacks_terminal.get()
  if not terminal then
    terminal = snacks_terminal.open()
  end

  local term_buf = terminal and terminal.buf
  local term_win = terminal and terminal.win

  -- Only call :show() if the window is NOT already open
  local win_valid = term_win and vim.api.nvim_win_is_valid(term_win)
  if not win_valid then
    terminal:show()
    -- refresh window handle
    term_win = terminal.win
  end

  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.schedule(function()
      if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_set_current_win(term_win)
      end
      vim.api.nvim_set_current_buf(term_buf)
      vim.cmd("startinsert")
      vim.api.nvim_feedkeys(text, "t", false)
      -- typewriter(text .. "\n", "t")

      vim.api.nvim_feedkeys("\r", "t", false) -- Enter
    end)
  else
    vim.notify("Could not find or open terminal.", vim.log.levels.ERROR)
  end
end

map("n", "<leader>te", function()
  execute_selection()
end, { desc = "execute in terminal" })
