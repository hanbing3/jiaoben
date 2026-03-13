#!/bin/bash
sh_download() {
    local script_path="$HOME/fbi.sh"
    # 全球直连，强制走我们自己的仓库
    curl -sS -o "$script_path" "https://raw.githubusercontent.com/hanbing3/jiaoben/main/fbi_core.sh"
    chmod +x "$script_path"
    "$script_path" "$@"
}
sh_download "$@"
