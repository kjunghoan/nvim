-- https://github.com/trixnz/sops.nvim
vim.pack.add({ "https://github.com/trixnz/sops.nvim" })

local sops = require("sops")
local sops_util = require("sops.util")

sops.setup({ disabled = true })

local sops_file_patterns =
  { "*.yaml", "*.yml", "*.json", "*.dockerconfigjson", "*.toml", "*.conf", "*.env" }

local function record_buffer_sops_status(buffer)
  if sops_util.is_sops_encrypted(buffer) then
    vim.b[buffer].sops_status = "encrypted"
  elseif vim.b[buffer].sops_status and vim.bo[buffer].buftype == "acwrite" then
    vim.b[buffer].sops_status = "decrypted"
  else
    vim.b[buffer].sops_status = nil
  end
  vim.cmd.redrawstatus()
end

vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("user-sops-status", { clear = true }),
  pattern = sops_file_patterns,
  callback = function(event)
    record_buffer_sops_status(event.buf)
  end,
})

local function encrypt_current_buffer_as_new_sops_file()
  local buffer = vim.api.nvim_get_current_buf()
  local path = vim.api.nvim_buf_get_name(buffer)
  if path == "" then
    vim.notify("SopsEncryptFile: buffer has no file name", vim.log.levels.WARN)
    return
  end
  if vim.b[buffer].sops_status then
    vim.notify("SopsEncryptFile: already a sops file: " .. path, vim.log.levels.WARN)
    return
  end

  local plaintext = table.concat(vim.api.nvim_buf_get_lines(buffer, 0, -1, false), "\n")
    .. "\n"
  local changedtick_at_start = vim.api.nvim_buf_get_changedtick(buffer)
  vim.system(
    { "sops", "encrypt", "--filename-override", path },
    { cwd = vim.fs.dirname(path), stdin = plaintext, text = true },
    vim.schedule_wrap(function(result)
      if result.code ~= 0 then
        vim.notify(
          "SopsEncryptFile: " .. (result.stderr or "unknown sops error"),
          vim.log.levels.ERROR
        )
        return
      end
      if
        not vim.api.nvim_buf_is_valid(buffer)
        or vim.api.nvim_buf_get_name(buffer) ~= path
        or vim.api.nvim_buf_get_changedtick(buffer) ~= changedtick_at_start
      then
        vim.notify(
          "SopsEncryptFile: buffer changed while encrypting, nothing written",
          vim.log.levels.ERROR
        )
        return
      end
      local ciphertext_lines = vim.split(result.stdout, "\n", { plain = true })
      if ciphertext_lines[#ciphertext_lines] == "" then
        table.remove(ciphertext_lines)
      end
      if vim.fn.writefile(ciphertext_lines, path) ~= 0 then
        vim.notify("SopsEncryptFile: failed to write " .. path, vim.log.levels.ERROR)
        return
      end
      vim.api.nvim_buf_call(buffer, function()
        vim.cmd("edit!")
      end)
    end)
  )
end

vim.api.nvim_create_user_command(
  "SopsEncryptFile",
  encrypt_current_buffer_as_new_sops_file,
  {}
)

vim.keymap.set("n", "<leader>et", "<cmd>SopsToggle<cr>", { desc = "Toggle decryption" })
vim.keymap.set("n", "<leader>ee", "<cmd>SopsEncryptFile<cr>", { desc = "Encrypt file" })
