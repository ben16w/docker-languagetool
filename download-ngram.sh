#!/bin/bash
set -e

NGRAMS_DIR="/ngrams"
DOWNLOAD_URL="http://languagetool.org/download/ngram-data"
TEMP_DIR="/tmp"

if [ -z "$NGRAMS_FILE" ]; then
    echo "NGRAMS_FILE not set. Skipping download."
    exit 0
fi

MARKER_FILE="$NGRAMS_DIR/.${NGRAMS_FILE}.complete"

# Skip if already downloaded
if [ -f "$MARKER_FILE" ]; then
    echo "N-grams already downloaded: $NGRAMS_FILE"
    exit 0
fi

echo "Downloading n-grams: $NGRAMS_FILE"

# Download and extract
mkdir -p "$NGRAMS_DIR"
TEMP_FILE="$TEMP_DIR/$NGRAMS_FILE"
curl -L --progress-bar "$DOWNLOAD_URL/$NGRAMS_FILE" -o "$TEMP_FILE"
unzip -q "$TEMP_FILE" -d "$NGRAMS_DIR"
rm "$TEMP_FILE"

# Mark as complete
touch "$MARKER_FILE"
echo "Download complete: $NGRAMS_FILE"
