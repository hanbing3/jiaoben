#!/bin/bash
echo "=== 开启深度清理与依赖重定向 ==="

# 1. 修复写死的域名
# 之前简单粗暴地把 kejilion 改成 fbi，导致很多原本可用的 kejilion 的 API 和网站（如 gh.kejilion.pro, api.kejilion.pro）
# 变成了 gh.kejilion.pro 等不存在的域名，这会引起很多网络请求报错、面板打不开。
# 对于不需要修改为 fbi 的基础服务，我们要恢复成 kejilion；对于需要指向 hanbing3/jiaoben 的 github 地址，要精确重定向。

find . -type f -name "*.sh" -exec sed -i 's/fbi\.pro/kejilion.pro/g' {} +
find . -type f -name "*.sh" -exec sed -i 's/fbi\.sh/kejilion.sh/g' {} +

# 恢复因为上面那步导致的我们自己名字的丢失，采用更精准的方式替换
# 面板上的展示名称 (只在 fbi_core.sh 中处理文本输出)
sed -i 's/KEJILION/FBI/g' fbi_core.sh
sed -i 's/kejilion/FBI/g' fbi_core.sh
sed -i 's/Kejilion/FBI/g' fbi_core.sh
sed -i 's/FBI\.sh/FBI/g' fbi_core.sh
sed -i 's/FBI.pro/kejilion.pro/g' fbi_core.sh # 误伤恢复
sed -i 's/api.FBI.pro/api.kejilion.pro/g' fbi_core.sh

# 2. 修复所有的 GitHub Raw 下载链接
# 原版有很多从 GitHub 下载其他组件的逻辑，必须让它去你自己的仓库 hanbing3/jiaoben 下载
sed -i 's|raw.githubusercontent.com/FBI/sh/main|raw.githubusercontent.com/hanbing3/jiaoben/main|g' fbi_core.sh
sed -i 's|raw.githubusercontent.com/kejilion/sh/main|raw.githubusercontent.com/hanbing3/jiaoben/main|g' fbi_core.sh
# 修复大陆镜像代理时的路径
sed -i 's|gh.kejilion.pro/raw.githubusercontent.com/FBI/sh/main|gh.kejilion.pro/raw.githubusercontent.com/hanbing3/jiaoben/main|g' fbi_core.sh
sed -i 's|gh.kejilion.pro/raw.githubusercontent.com/kejilion/sh/main|gh.kejilion.pro/raw.githubusercontent.com/hanbing3/jiaoben/main|g' fbi_core.sh

# 3. 针对引导脚本(kejilion.sh) 同样进行处理
sed -i 's|raw.githubusercontent.com/kejilion/sh/main|raw.githubusercontent.com/hanbing3/jiaoben/main|g' kejilion.sh
sed -i 's|gh.kejilion.pro/raw.githubusercontent.com/kejilion/sh/main|gh.kejilion.pro/raw.githubusercontent.com/hanbing3/jiaoben/main|g' kejilion.sh

# 4. 彻底禁用数据回传
sed -i 's/ENABLE_STATS="true"/ENABLE_STATS="false"/g' fbi_core.sh

# 5. 清理没用的翻译、日志等
rm -f kejilion_sh_log.txt fbi_sh_log.txt || true

echo "提交修复..."
git add .
git commit -m "Deep clean: fix broken domains, redirect raw downloads to hanbing3, restore API paths"
git push origin main
echo "=== 深度清理完成 ==="
