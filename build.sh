#!/usr/bin/env bash

set -x
set -e

# 检查 bin/mdbook 是否存在
if [ ! -f "bin/mdbook" ]; then
    echo "mdbook not found in bin/, downloading and extracting..."
    
    # 创建 bin 目录（如果不存在）
    mkdir -p bin
    
    # 下载 mdbook 预编译包
    MDBOOK_URL="https://github.com/rust-lang/mdBook/releases/download/v0.5.2/mdbook-v0.5.2-aarch64-apple-darwin.tar.gz"
    TAR_FILE="bin/mdbook.tar.gz"
    
    echo "Downloading mdbook from $MDBOOK_URL..."
    if ! curl -L -o "$TAR_FILE" "$MDBOOK_URL"; then
        echo "Error: Failed to download mdbook"
        exit 1
    fi
    
    # 解压到 bin 目录
    echo "Extracting mdbook..."
    if ! tar -xzf "$TAR_FILE" -C bin; then
        echo "Error: Failed to extract mdbook"
        exit 1
    fi
    
    # 清理临时文件
    rm -f "$TAR_FILE"
    
    # 确保可执行权限
    chmod +x "bin/mdbook"
    
    echo "mdbook successfully installed in bin/"
fi

# 运行 mdbook 构建
"bin/mdbook" build -d docs