#!/usr/bin/env bash

# Close System Preferences just in case
osascript -e 'tell application "System Preferences" to quit'

# Set custom terminal theme
./set_terminal_theme.applescript

# Disable startup noise
sudo nvram SystemAudioVolume=%01

# Enable SSH
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist

# Set highlight color to green
defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

# Make crash reports appear as notifications
defaults write com.apple.CrashReporter UseUNC 1

# Set language
defaults write -g AppleLanguages -array "en"

# Set measurement units
defaults write -g AppleMeasurementUnits -string "Centimeters"

# Turn on auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Enable automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files and security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Enable tab in modal dialogs
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Scrollbars visible when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Set dark theme
sudo defaults write /Library/Preferences/.GlobalPreferences AppleInterfaceTheme Dark

# Set minimal autohide/show delay for hidden dock
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Enable scroll gestures for Dock icons
defaults write com.apple.dock scroll-to-open -bool true

# Disable autocorrect
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Save screenshots as PNG
defaults write com.apple.screencapture type -string "png"

# Save screenshots to the Desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop/screenshots" 

# Enable subpixel font rendering on non-Apple LCDs
defaults write -g AppleFontSmoothing -int 2

# Disable Dock magnification
defaults write com.apple.dock magnification -bool false

# Minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator lights for open apps in Dock
defaults write com.apple.dock show-process-indicators -bool true

#  Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

### Finder ###

# Set sidebar icon size to medium
defaults write -g NSTableViewDefaultSizeMode -int 2

# Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Don't show Finder status bar
defaults write com.apple.finder ShowStatusBar -bool false

# Don't show Finder path bar
defaults write com.apple.finder ShowPathbar -bool false

# Disable Quick Look animation
defaults write -g QLPanelAnimationDuration -float 0

# Disable Get Info animation (cmd + i)
defaults write com.apple.finder DisableAllAnimations -bool true

# Show ~/Library
chflags nohidden ~/Library

# Show /Volumes
sudo chflags nohidden /Volumes

# Use column view in Finder by default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# New Finder window opens in home directory
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Disable warning when emptying trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Do not show recent tags
defaults write com.apple.finder ShowRecentTags -bool false

# Show all filename extensions
defaults write -g AppleShowAllExtensions -bool true

### Safari ###

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Disable delay when rendering web pages
defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25

# Prevent Safari from opening files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true && \
defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true && \
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
defaults write -g WebKitDeveloperExtras -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Disable autocorrect in Safari
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Show the full URL in the address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Disable auto-playing video
#defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
#defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
#defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

### Activity Monitor ###

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Force dark/native UI in some "legacy" apps.
# This only changes context menus and Finder windows when opening/saving files
# Syntax: defaults write com.adobe.illustrator NSRequiresAquaSystemAppearance 0
defaults write org.m0k.transmission NSRequiresAquaSystemAppearance 0

killall Safari
killall Dock
killall Finder

# Starting with Mac OS X Mavericks preferences are cached,
# so in order for things to get properly set using `PlistBuddy`,
# the `cfprefsd` process also needs to be killed.
#
# https://github.com/alrra/dotfiles/commit/035dda057ddc6013ba21db3d2c30eeb51ba8f200

killall cfprefsd