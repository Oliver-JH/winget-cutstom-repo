#!/bin/bash

# 스크립트 실행 시 관리자 권한 요청
if [ "$EUID" -ne 0 ]; then
    echo "관리자 권한으로 실행해야 합니다. sudo를 사용하세요."
    exit 1
fi

# 현재 날짜 출력 (디버깅용)
echo "스크립트 시작: $(date)"

# Homebrew 설치 확인 및 설치
if ! command -v brew &>/dev/null; then
    echo "Homebrew 설치 중..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Apple Silicon Mac에서 PATH 설정
    if [ -d "/opt/homebrew/bin" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    fi
else
    echo "Homebrew가 이미 설치되어 있습니다."
fi

# Homebrew 버전 확인
brew -v

# Google Chrome 설치
echo "Google Chrome 설치 중..."
brew install --cask google-chrome

# FortiClient 설치 (VPN 전용 버전은 Homebrew로 직접 지원되지 않으므로 dmg 사용)
echo "FortiClient 설치 중..."
# Homebrew로 전체 FortiClient 설치 (옵션 1)
# brew install --cask forticlient

# 공식 VPN 전용 dmg 다운로드 및 설치 (옵션 2)
FORTICLIENT_URL="https://links.fortinet.com/forticlient/mac/vpnagent"
FORTICLIENT_DMG="/tmp/FortiClientVPN.dmg"
curl -L "$FORTICLIENT_URL" -o "$FORTICLIENT_DMG"
hdiutil attach "$FORTICLIENT_DMG"
sudo installer -pkg "/Volumes/FortiClientVPN/FortiClientVPN.pkg" -target /
hdiutil detach "/Volumes/FortiClientVPN"
rm "$FORTICLIENT_DMG"

# FortiClient VPN 설정 파일 준비
echo "FortiClient VPN 설정 추가 중..."
VPN_CONFIG_DIR="/Applications/FortiClient.app/Contents/Resources/runtime.helper"
sudo mkdir -p "$VPN_CONFIG_DIR"

# VPN 설정 예시 (XML 형식)


# FortiClient 실행 및 설정 적용 (GUI 열기)
open -a "FortiClient"

echo "설치 및 설정이 완료되었습니다. FortiClient를 열어 VPN 연결을 확인하세요."
echo "스크립트 종료: $(date)"
