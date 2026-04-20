#!/usr/bin/env bash

set -x
set -e

# 检查 bin/mdbook 是否存在
if [ ! -f "bin/mdbook" ]; then
    echo "mdbook not found in bin/, downloading and extracting..."
    
    # 创建 bin 目录（如果不存在）
    mkdir -p bin
    
    # 根据平台和架构选择对应的安装包
    MDBOOK_VERSION="v0.5.2"
    OS="$(uname -s)"
    ARCH="$(uname -m)"

    case "${OS}" in
        Linux)
            case "${ARCH}" in
                x86_64)  TARGET="x86_64-unknown-linux-gnu" ;;
                aarch64) TARGET="aarch64-unknown-linux-gnu" ;;
                *) echo "Error: Unsupported Linux architecture: ${ARCH}"; exit 1 ;;
            esac
            ;;
        Darwin)
            case "${ARCH}" in
                x86_64)  TARGET="x86_64-apple-darwin" ;;
                arm64)   TARGET="aarch64-apple-darwin" ;;
                *) echo "Error: Unsupported macOS architecture: ${ARCH}"; exit 1 ;;
            esac
            ;;
        *)
            echo "Error: Unsupported OS: ${OS}"
            exit 1
            ;;
    esac

    MDBOOK_URL="https://github.com/rust-lang/mdBook/releases/download/${MDBOOK_VERSION}/mdbook-${MDBOOK_VERSION}-${TARGET}.tar.gz"
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
rm -rf html
"bin/mdbook" build -d html