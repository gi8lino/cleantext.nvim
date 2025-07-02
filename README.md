# CleanText.nvim

Removes smart quotes, em dashes, and other “weird” characters before saving files.

## 🔧 Setup (Lazy.nvim)

```lua
{
  "gi8lino/nvim-cleantext",
  config = function()
    require("cleantext").setup({
      replacements = {
        ["—"] = "-",
        ["ß"] = "ss",
      }
    })

    vim.keymap.set("n", "<leader>ct", function()
      require("cleantext").toggle()
    end, { desc = "Toggle CleanText", silent = true })
  end,
```
