[![GitHub Releases](https://img.shields.io/github/downloads/atiladefreitas/lazyclip/total)](https://github.com/atiladefreitas/lazyclip/releases) [![GitHub tag](https://img.shields.io/github/tag/atiladefreitas/lazyclip.svg)](https://github.com/atiladefreitas/lazyclip/releases/latest)


# LazyClip

LazyClip is a powerful yet minimalist clipboard manager for Neovim, designed with simplicity and efficiency in mind. It integrates seamlessly with your Neovim setup and provides an intuitive floating window to browse and paste clipboard history. LazyClip is especially crafted for users of **Lazy.nvim** and works great with popular Neovim distributions.

## 🚀 Features

- 📋 View up to **9 clipboard items** per page in a **floating window**.
- 🔢 Fixed numbered slots `[1]` to `[9]` for quick reference.
- 🌟 **Paste with ease**: Use number keys or `<Enter>` to paste items directly into your editor.
- ⏮️ Navigate clipboard history with `H` (previous page) and `L` (next page).
- 🛠️ Compatible with **Lazy.nvim** for effortless installation.

---

## 📦 Installation

### Prerequisites

- Neovim `>= 0.10.0`
- [Lazy.nvim](https://github.com/folke/lazy.nvim) as your plugin manager.

### Using Lazy.nvim

```lua
return {
    {
        "atiladefreitas/lazyclip",
        config = function()
            require("lazyclip").setup()
        end,
        keys = {
            { "<leader>Cw", ":lua require('lazyclip').show_clipboard()<CR>", desc = "Open Clipboard Manager" },
        },
    },
}
```

Run the following commands in Neovim to install LazyClip:

```vim
:Lazy sync
```

---

## 🔑 Keybindings

LazyClip comes with intuitive keybindings:

| Key      | Action                                      |
|----------|---------------------------------------------|
| `<leader>Cw` | Open the clipboard manager window          |
| `1-9`    | Paste the corresponding clipboard item      |
| `<Enter>`| Paste the currently selected item           |
| `h`      | Go to the previous page of clipboard history |
| `l`      | Go to the next page of clipboard history     |
| `q`      | Close the clipboard manager window          |

---

## 🛠️ Usage

1. **Yank text** in Neovim as usual using commands like `y`, `yy`, or `yank`.
2. Open LazyClip with `<leader>Cw`.
3. Browse through the last **9 copied items** in a floating window.
4. **Paste an item**:
   - Press the corresponding **number key** (`1-9`).
   - Or, navigate to the desired item with `j`/`k` and press `<Enter>`.
5. Use `h` and `l` to navigate pages when you have more than 9 items.
6. Press `q` to close the window.

---

## 📥 Backlog

Planned features and improvements for future versions of LazyClip:

#### Core Features

- [ ] System Clipboard Integration.
- [ ] Persistent Clipboard History.
- [ ] Search Clipboard History
- [ ] Clipboard Size Configuration

#### UI Enhancements

- [ ] Customizable Floating Window.
- [ ] Highlight Current Item.
- [ ] Multi-Item Paste.

#### Quality of Life

- [ ] Keybinding Configurability.
- [ ] Better Error Messages.
- [ ] Performance Optimization.

---

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 🔖 Versioning

We use [Semantic Versioning](https://semver.org/) for versioning. For the available versions, see the [tags on this repository](https://github.com/atiladefreitas/lazyclip/tags).

### Current Version: **v0.1.0**

---

## 🤝 Contributing

Contributions are welcome! If you'd like to improve LazyClip, feel free to:
- Submit an issue for bugs or feature requests.
- Create a pull request with your enhancements.

---

## 🌟 Acknowledgments

LazyClip was built with the Neovim community in mind. Special thanks to all the developers who contribute to the Neovim ecosystem and plugins like [Lazy.nvim](https://github.com/folke/lazy.nvim).

---

## 📬 Contact

If you have any questions, feel free to reach out:
- [LinkedIn](https://linkedin.com/in/atilafreitas)
- Email: contact@atiladefreitas.com

