# CleanText.nvim

Removes smart quotes, em dashes, and other “weird” characters before saving files.

## 🔧 Setup (Lazy.nvim)

```lua
{
  "gi8lino/cleantext.nvim",
  config = function()
    require("cleantext.nvim").setup({
      replacements = {
        ["—"] = "-",
        ["ß"] = "ss",
      }
    })

    vim.keymap.set("n", "<leader>ct", function()
      require("cleantext.nvim").toggle()
    end, { desc = "Toggle CleanText", silent = true })
  end,
```
