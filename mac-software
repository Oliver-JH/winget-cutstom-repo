xcode-select --install

if ! command -v brew &>/dev/null; then
    echo "Homebrew 설치 중..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew -v

# 기본 소프트웨어 자동 설치
brew install --cask google-chrome
brew install --cask forticlient

# 시스템 설정 자동 변경 (예제)
defaults write com.apple.dock autohide -bool true
killall Dock
