#!/bin/bash
# Git smudge/clean filter for secrets in settings.json
# 秘钥从 .secrets 文件动态读取，不硬编码在脚本中。
#
# 使用方式（一次性配置）：
#   git config filter.secret-filter.clean 'scripts/git-secret-filter.sh clean'
#   git config filter.secret-filter.smudge 'scripts/git-secret-filter.sh smudge'
#
# .secrets 文件格式（放在仓库根目录，不提交）：
#   KEY_NAME=actual_secret_value

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SECRETS_FILE="$REPO_ROOT/.secrets"

filter_clean() {
    if [ ! -f "$SECRETS_FILE" ]; then
        cat
        return
    fi

    local sed_expr=""
    local sep=$'\x01'

    while IFS='=' read -r key value || [ -n "$key" ]; do
        key="${key%%#*}"
        key="$(echo "$key" | tr -d '[:space:]')"
        [ -z "$key" ] && continue
        value="${value#\"}"; value="${value%\"}"
        value="${value#\'}"; value="${value%\'}"

        # 跳过占位符本身（防止重复替换）
        [[ "$value" == __*__ ]] && continue

        sed_expr="${sed_expr}s${sep}${value}${sep}__${key}__${sep}g;"
    done < "$SECRETS_FILE"

    sed "$sed_expr"
}

filter_smudge() {
    if [ ! -f "$SECRETS_FILE" ]; then
        cat
        return
    fi

    local sed_expr=""
    local sep=$'\x01'

    while IFS='=' read -r key value || [ -n "$key" ]; do
        key="${key%%#*}"
        key="$(echo "$key" | tr -d '[:space:]')"
        [ -z "$key" ] && continue
        value="${value#\"}"; value="${value%\"}"
        value="${value#\'}"; value="${value%\'}"

        sed_expr="${sed_expr}s${sep}__${key}__${sep}${value}${sep}g;"
    done < "$SECRETS_FILE"

    sed "$sed_expr"
}

case "${1:-}" in
    clean) filter_clean ;;
    smudge) filter_smudge ;;
    *)
        echo "Usage: $0 {clean|smudge}" >&2
        exit 1
        ;;
esac
