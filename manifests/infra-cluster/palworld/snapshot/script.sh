#! /bin/sh

set -eu

if [ -z "${AWS_ENDPOINT_URL}" ]; then
  echo "AWS_ENDPOINT_URL is not set"
  exit 1
fi

RESTIC_REPOSITORY="s3:${AWS_ENDPOINT_URL%/}/palworld"

restic -r "${RESTIC_REPOSITORY?}" init || true
restic -r "${RESTIC_REPOSITORY?}" --verbose backup /mnt/source/steamapps/common/PalServer/Pal/Saved/SaveGames
restic -r "${RESTIC_REPOSITORY?}" forget --group-by=paths --keep-monthly 6 --keep-daily 7 --keep-last 36 --prune
