#!/bin/bash
# FBI 专属引导脚本
sh_download() {
    local script_path="$HOME/kejilion.sh"
    # 直接拉取 fbi_core.sh
    curl -sS -o "$script_path" "https://raw.githubusercontent.com/hanbing3/jiaoben/main/fbi_core.sh"
    chmod +x "$script_path"
    "$script_path" "$@"
}
sh_download "$@"
