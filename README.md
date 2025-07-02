# 🧹 CleanText.nvim

A lightweight Neovim plugin that automatically replaces typographic symbols like smart quotes, em dashes, and ellipses with simpler ASCII characters **before saving** any buffer.

> ✨ Perfect for developers who hate copying curly quotes from docs or emails into their code.

## 🔧 Setup (Lazy.nvim)

```lua
{
  "gi8lino/cleantext.nvim",
  opts = {
    replacements = {
      ["ß"] = "ss", -- Add or override any replacements
    },
  },
  keys = {
    {
      "<leader>ct",
      function()
        require("cleantext").toggle()
      end,
      desc = "Toggle CleanText",
    },
  },
}
```

## 🗃️ Default Replacements

The following replacements are applied by default:

| Character | Replacement |
| --------: | ----------- |
|         “ | `"`         |
|         ” | `"`         |
|         ‘ | `'`         |
|         ’ | `'`         |
|         — | `--`        |
|         – | `-`         |
|         … | `...`       |

You can **override** or **extend** the replacement list by passing a `replacements` table in the `opts`.

- **To override** an entry: just redefine it.
- **To add new entries**: provide additional keys.

Example:

```lua
opts = {
  replacements = {
    ["—"] = "-",   -- override default
    ["ß"] = "ss",  -- add new
  },
}
```

## ⚙️ Features

- Replaces characters on `BufWritePre` (before saving)
- Toggleable via Lua (`require("cleantext").toggle()`)
- Works on all filetypes by default
- Minimal and fast — pure Lua

## 📟 Statusline Integration (Optional)

You can show whether CleanText is currently enabled:

```lua
require("cleantext").status() -- returns "CleanText: ON" or "CleanText: OFF"
```

## 📄 License

MIT © [gi8lino](https://github.com/gi8lino)
