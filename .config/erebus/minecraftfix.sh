#!/bin/bash

# The full path to the OpenAL Soft configuration file
CONFIG_FILE="$HOME/.alsoftrc"

# The configuration content to be added
CONFIG_CONTENT="
drivers=pulse

[pulse]
allow-moves=yes
"

echo "Applying Minecraft sound fix..."

# Check if the file already exists and contains the configuration
if [ -f "$CONFIG_FILE" ] && grep -q "drivers=pulse" "$CONFIG_FILE"; then
    echo "✅ Sound fix is already present in $CONFIG_FILE. No changes needed."
else
    # Append the configuration to the file. The -e flag for echo allows
    # for the interpretation of backslash escapes like \n for a new line.
    echo -e "\n# Minecraft/OpenAL Sound Fix\n$CONFIG_CONTENT" >> "$CONFIG_FILE"
    echo "✅ Sound fix has been successfully added to $CONFIG_FILE."
fi

echo "Done."
