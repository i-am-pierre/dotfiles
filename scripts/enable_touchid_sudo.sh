#!/bin/sh

PAM_FILE="/etc/pam.d/sudo"
TOUCHID_LINE="auth       sufficient     pam_tid.so"

# Check if the line already exists
if grep -Fq "$TOUCHID_LINE" "$PAM_FILE"; then
    echo "Touch ID is already enabled for sudo."
    exit 0
fi

echo "Enabling Touch ID for sudo..."

# Create a temporary file
TMP_FILE="$(mktemp)"

# Add Touch ID line at the top, then append the rest of the original file
{
    echo "$TOUCHID_LINE"
    cat "$PAM_FILE"
} > "$TMP_FILE"

# Replace the original file with the new one (requires sudo)
sudo cp "$TMP_FILE" "$PAM_FILE"
rm "$TMP_FILE"

echo "Touch ID enabled for sudo."
