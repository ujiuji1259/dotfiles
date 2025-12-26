return {
    'dense-analysis/ale',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        -- ALEの基本設定
        vim.g.ale_echo_msg_error_str = 'E'
        vim.g.ale_echo_msg_warning_str = 'W'
        vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'

        vim.g.ale_python_auto_uv = 1  -- 仮想環境を自動検出
        vim.g.ale_python_ruff_auto_uv = 1  -- ruff用の仮想環境を自動検出
        vim.g.ale_python_mypy_auto_uv = 1  -- mypy用の仮想環境を自動検出
        vim.g.ale_python_ruff_change_directory = 1
        -- vim.g.ale_python_ruff_options = '--config pyproject.toml'
        -- vim.g.ale_python_mypy_options = '--config-file pyproject.toml'
        vim.g.ale_linters_explicit = 1

        -- Python用のlinter設定
        vim.g.ale_linters = {
            python = {'ruff', 'mypy'}
        }

        -- Python用のfixer設定
        vim.g.ale_fixers = {
            python = {'ruff', 'ruff_format'}
        }

        -- 保存時に自動fix/format実行
        vim.g.ale_fix_on_save = 1

        -- lintを有効にする
        vim.g.ale_lint_on_text_changed = 'normal'
        vim.g.ale_lint_on_insert_leave = 1
        vim.g.ale_lint_on_enter = 1
        vim.g.ale_lint_on_save = 1

        -- サインカラムを常に表示
        vim.g.ale_sign_column_always = 1

        -- エラーと警告のサイン設定
        vim.g.ale_sign_error = '✘'
        vim.g.ale_sign_warning = '⚠'
        vim.g.ale_sign_info = 'ⓘ'
        vim.g.ale_sign_style_error = '✘'
        vim.g.ale_sign_style_warning = '⚠'


        -- noice連携のための設定
        vim.g.ale_virtualtext_cursor = 'disabled'
        vim.g.ale_echo_cursor = 0  -- カーソル位置でのエコーメッセージを無効
        vim.g.ale_floating_preview = 0  -- フローティングプレビューを無効
        vim.g.ale_hover_cursor = 0  -- カーソルホバー情報を無効
    end,
}
