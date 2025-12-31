return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- FZF native for better performance
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    -- Additional useful extensions
    "nvim-telescope/telescope-project.nvim",
    "nvim-telescope/telescope-github.nvim",
    "debugloop/telescope-undo.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        -- Configure hidden and ignored files similar to snacks picker
        hidden = true,
        preview = {
          treesitter = false,
        },
        file_ignore_patterns = {
          "**/.venv/**",
          ".venv/**",
          ".mypy_cache/**",
          "*.pyc",
          "__pycache__/**",
          "node_modules/**",
          ".git/**",
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        undo = {
          use_delta = true,
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
        },
      },
    })

    -- Load extensions
    telescope.load_extension("fzf")
    telescope.load_extension("project")
    telescope.load_extension("gh")
    telescope.load_extension("undo")

    -- Helper functions for custom pickers
    local function find_config_files()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end

    local function grep_open_buffers()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end

    local function search_dotfiles()
      builtin.find_files({
        cwd = "~/dotfiles",
        prompt_title = "Find Dotfiles",
      })
    end

    -- Smart find files function (similar to snacks smart finder)
    local function smart_find_files()
      local ok = pcall(builtin.git_files, {
        show_untracked = true,
      })
      if not ok then
        builtin.find_files()
      end
    end

    return {
      -- Helper functions for use in keymaps
      smart_find_files = smart_find_files,
      find_config_files = find_config_files,
      grep_open_buffers = grep_open_buffers,
      search_dotfiles = search_dotfiles,
    }
  end,
  keys = {
    -- Top Pickers & Explorer
    { "<leader><space>", function() require("telescope.builtin").find_files() end, desc = "Smart Find Files" },
    { "<leader>,", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
    { "<leader>/", function() require("telescope.builtin").live_grep() end, desc = "Grep" },
    { "<leader>:", function() require("telescope.builtin").command_history() end, desc = "Command History" },
    { "<leader>n", function() require("telescope.builtin").notify() end, desc = "Notification History" },

    -- Find
    { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
    { "<leader>fc", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
    { "<leader>fg", function() require("telescope.builtin").git_files() end, desc = "Find Git Files" },
    { "<leader>fp", function() require("telescope").extensions.project.project() end, desc = "Projects" },
    { "<leader>fr", function() require("telescope.builtin").oldfiles() end, desc = "Recent" },

    -- Git
    { "<leader>gb", function() require("telescope.builtin").git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() require("telescope.builtin").git_commits() end, desc = "Git Log" },
    { "<leader>gL", function() require("telescope.builtin").git_bcommits() end, desc = "Git Log Line" },
    { "<leader>gs", function() require("telescope.builtin").git_status() end, desc = "Git Status" },
    { "<leader>gS", function() require("telescope.builtin").git_stash() end, desc = "Git Stash" },
    { "<leader>gd", function() require("telescope.builtin").git_status() end, desc = "Git Diff (Status)" },
    { "<leader>gf", function() require("telescope.builtin").git_bcommits() end, desc = "Git Log File" },

    -- GitHub (requires telescope-github extension)
    { "<leader>gi", function() require("telescope").extensions.gh.issues() end, desc = "GitHub Issues (open)" },
    { "<leader>gI", function() require("telescope").extensions.gh.issues({ state = "all" }) end, desc = "GitHub Issues (all)" },
    { "<leader>gp", function() require("telescope").extensions.gh.pull_request() end, desc = "GitHub Pull Requests (open)" },
    { "<leader>gP", function() require("telescope").extensions.gh.pull_request({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },

    -- Grep
    { "<leader>sb", function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Buffer Lines" },
    { "<leader>sB", function() require("telescope.builtin").live_grep({ grep_open_files = true }) end, desc = "Grep Open Buffers" },
    { "<leader>sg", function() require("telescope.builtin").live_grep() end, desc = "Grep" },
    { "<leader>sw", function() require("telescope.builtin").grep_string() end, desc = "Visual selection or word", mode = { "n", "x" } },

    -- Search
    { '<leader>s"', function() require("telescope.builtin").registers() end, desc = "Registers" },
    { '<leader>s/', function() require("telescope.builtin").search_history() end, desc = "Search History" },
    { "<leader>sc", function() require("telescope.builtin").command_history() end, desc = "Command History" },
    { "<leader>sC", function() require("telescope.builtin").commands() end, desc = "Commands" },
    { "<leader>sd", function() require("telescope.builtin").diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() require("telescope.builtin").help_tags() end, desc = "Help Pages" },
    { "<leader>sH", function() require("telescope.builtin").highlights() end, desc = "Highlights" },
    { "<leader>si", function() require("telescope.builtin").symbols() end, desc = "Icons/Symbols" },
    { "<leader>sj", function() require("telescope.builtin").jumplist() end, desc = "Jumps" },
    { "<leader>sk", function() require("telescope.builtin").keymaps() end, desc = "Keymaps" },
    { "<leader>sl", function() require("telescope.builtin").loclist() end, desc = "Location List" },
    { "<leader>sm", function() require("telescope.builtin").marks() end, desc = "Marks" },
    { "<leader>sM", function() require("telescope.builtin").man_pages() end, desc = "Man Pages" },
    { "<leader>sp", function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end, desc = "Search for Plugin Spec" },
    { "<leader>sq", function() require("telescope.builtin").quickfix() end, desc = "Quickfix List" },
    { "<leader>sR", function() require("telescope.builtin").resume() end, desc = "Resume" },
    { "<leader>su", function() require("telescope").extensions.undo.undo() end, desc = "Undo History" },
    { "<leader>uC", function() require("telescope.builtin").colorscheme() end, desc = "Colorschemes" },

    -- LSP
    { "gd", function() require("telescope.builtin").lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() require("telescope.builtin").lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() require("telescope.builtin").lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() require("telescope.builtin").lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() require("telescope.builtin").lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "gai", function() require("telescope.builtin").lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
    { "gao", function() require("telescope.builtin").lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
    { "<leader>ss", function() require("telescope.builtin").lsp_document_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "LSP Workspace Symbols" },
  },
}
