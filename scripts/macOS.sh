#!/usr/bin/env bash
# File: macOS.sh

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

echo "Setting up my Defaults:"

###############################################################################
# Finder                                                                      #
###############################################################################
echo "Finder..."

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

echo "Dock, Dashboard, and hot corners..."

# Set the icon size of Dock items to 16 pixels
defaults write com.apple.dock tilesize -integer 16

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock magnification -bool true

# Setting hot corners
# Set Top left to Start screen Saver
defaults write com.apple.dock wvous-tl-corner -integer 5
# Set Bottom left to Misson Control
defaults write com.apple.dock wvous-bl-corner -integer 2
# Set Bottom right to Desktop
defaults write com.apple.dock wvous-br-corner -integer 4


###############################################################################
# Safari & WebKit                                                             #
###############################################################################

echo "Safari..."
# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

###############################################################################
# Terminal                                                                    #
###############################################################################

echo "Terminal..."
# Copy my prefences plist into ~/Library/Prefrences
if [ -f "com.apple.Terminal.plist" ] ; then
  cp com.apple.Terminal.plist $HOME/Library/Preferences
fi

for app in "Activity Monitor" \
	"Dock" \
	"Finder" \
	"Safari" \ ; do
	killall "${app}" &> /dev/null
done

echo -e "Done. Some of these changes require a logout/restart to take effect."
