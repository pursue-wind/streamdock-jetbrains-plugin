#!/bin/sh
path=$path:/opt/homebrew/bin/
echo 'Killing the Stream Deck process'

if [[ "$OSTYPE" == "msys" ]]; then
  taskkill //IM "StreamDeck.exe" //F
else
  pkill 'Stream Dock AJAZZ'
fi

pluginName='com.jetbrains.ide'

if [[ "$OSTYPE" == "msys" ]]; then
  pluginsDir="$HOME\AppData\Roaming\Elgato\StreamDeck\Plugins"
else
  pluginsDir="$HOME/Library/Application Support/HotSpot/StreamDock/plugins"
fi
projectDir=$(PWD)

echo 'Building from sources'
npm run build

echo "Installing the $pluginName plugin to $pluginsDir"

# Push the plugins directory on the stack
pushd "$pluginsDir"

# Check if the plugin directory exists and remove it
[ -d "$pluginName.sdPlugin" ] && rm -r $pluginName.sdPlugin
# Create the plugins directory
mkdir $pluginName.sdPlugin

# Copy content from local folder to Application folder
if [[ "$OSTYPE" == "msys" ]]; then
  cp -R "$projectDir/$pluginName.sdPlugin" .
else
  cp -R "$projectDir/$pluginName.sdPlugin/" $pluginName.sdPlugin
fi

# Pop the plugins directory off the stack returning to where we were
popd

echo "Done installing ${pluginName}"

# Reopen the Stream Deck app on background
if [[ "$OSTYPE" == "msys" ]]; then
  "C:\Program Files\Elgato\StreamDeck\StreamDeck.exe" &
else
  open -a /Applications/Stream\ Dock\ AJAZZ.app/
fi
exit