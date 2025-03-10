#!/bin/bash

# 저장소 경로
REPO_PATH="$HOME/algorithm/Leethub-3.0"

LAST_MONDAY_UTC=$(date -v-mon -v0H -v0M -v0S -u "+%s")
CURRENT_TIME=$(date "+%s")

# 로그 파일
LOG_FILE="$REPO_PATH/logs/git-auto-update.log"
ERROR_LOG_FILE="$REPO_PATH/logs/git-auto-update-error.log"

echo "[$(date)] Running git pull..." >> "$LOG_FILE"
cd "$REPO_PATH" || exit

# git pull 실행
PULL_RESULT=$(git pull origin main 2>&1)
PULL_STATUS=$?

# git pull 결과에 따른 처리
if [ "$PULL_STATUS" -eq 0 ]; then
  if [[ "$PULL_RESULT" == *"Already up to date."* ]]; then
    echo "[$(date)] No changes, already up to date." >> "$LOG_FILE"
  else
    echo "[$(date)] Successfully pulled updates." >> "$LOG_FILE"
  fi
else
  echo "[$(date)] Failed to pull updates: $PULL_RESULT" >> "$ERROR_LOG_FILE"
fi

