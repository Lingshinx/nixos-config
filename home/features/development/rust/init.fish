#!/usr/bin/env fish

set rustup (which rustup)

if type -q rustup
    echo "Rustup detected, checking toolchain and components..."

    # 检查 stable toolchain 是否存在
    if not rustup toolchain list | grep -q stable
        echo "Installing stable toolchain..."
        rustup toolchain install stable
        rustup default stable
    else
        echo "Stable toolchain already installed."
    end

    # 检查 rust-analyzer 是否存在
    if not rustup component list --installed | grep -q rust-analyzer
        echo "Installing rust-analyzer component..."
        rustup component add rust-analyzer
    else
        echo "rust-analyzer already installed."
    end
else
    echo "Rustup not found, skipping initialization."
end
