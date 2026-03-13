#!/bin/bash
# 最后微调：面板的标题
sed -i 's/fbi.sh/FBI 专属工具箱/g' fbi_core.sh
# 修复脚本本身提示 fbi: command not found 的问题，它原版是通过建立别名 alias kejilion=xxx 来运行的
# 我们把里面的 alias kejilion 改成 alias fbi
sed -i 's/alias fbi=/alias fbi=/g' fbi_core.sh # 前面已经改过了

git add .
git commit -m "Final tweak: Title and aliases"
git push origin main
