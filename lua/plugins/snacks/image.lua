-- https://github.com/folke/snacks.nvim/blob/main/docs/image.md
return {
  opts = {
    image = {
      enabled = true,
      formats = (function()
        local lowercase_formats = {
          "png",
          "jpg",
          "jpeg",
          "gif",
          "bmp",
          "webp",
          "tiff",
          "heic",
          "avif",
          "mp4",
          "mov",
          "avi",
          "mkv",
          "webm",
          "pdf",
          "icns",
        }
        local formats_with_uppercase = {}
        for _, format in ipairs(lowercase_formats) do
          formats_with_uppercase[#formats_with_uppercase + 1] = format
          formats_with_uppercase[#formats_with_uppercase + 1] = format:upper()
        end
        return formats_with_uppercase
      end)(),
    },
  },
  init = function()
    require("util.image_buffer").register_autocmd()
    require("util.pdf_pager").register_autocmd()
  end,
  keys = {
    {
      "<leader>i",
      function()
        local image = require("snacks.image")
        local buf = vim.api.nvim_get_current_buf()
        image.config.doc.inline = not image.config.doc.inline
        pcall(vim.api.nvim_del_augroup_by_name, "snacks.image.doc." .. buf)
        pcall(vim.api.nvim_del_augroup_by_name, "snacks.image.inline." .. buf)
        Snacks.image.placement.clean(buf)
        vim.b[buf].snacks_image_attached = nil
        Snacks.image.doc.attach(buf)
        Snacks.notify("Image: " .. (image.config.doc.inline and "inline" or "hover float"))
      end,
      desc = "Toggle image render: inline / hover float",
    },
  },
}
