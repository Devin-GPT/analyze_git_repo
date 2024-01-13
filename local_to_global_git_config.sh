# Fetch the current local settings
local_name=$(git config --get --local user.name)
local_email=$(git config --get --local user.email)
local_gpg_key=$(git config --get --local user.signingkey)
local_commit_sign=$(git config --get --local commit.gpgsign)

# Apply the settings to the global configuration
[ -n "$local_name" ] && git config --global user.name "$local_name"
[ -n "$local_email" ] && git config --global user.email "$local_email"
[ -n "$local_gpg_key" ] && git config --global user.signingkey "$local_gpg_key"
[ -n "$local_commit_sign" ] && git config --global commit.gpgsign "$local_commit_sign"

echo "Local Git settings have been merged into the global configuration."

