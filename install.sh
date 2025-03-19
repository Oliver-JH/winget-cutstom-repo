xcode-select --install

# Homebrew 설치 확인 및 설치
if ! command -v brew &>/dev/null; then
    echo "Homebrew 설치 중..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Homebrew 버전 확인
brew -v

# 예시: 소프트웨어 설치
brew install --cask google-chrome
brew install --cask forticlient

defaults write com.apple.dock autohide -bool true
killall Dock
