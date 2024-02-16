

<image style="display: inline-block;" src="Media/AppIcons/64.png" />

# Script Manager (macOS)

An easy and comfortable macOS **menu bar-tool**, to organize and use your own terminal-scripts.

<p align="center">
  <a href="https://github.com/DanielFiller30/ScriptManager/blob/main/LICENSE.md">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="Script Manager is released under the MIT license." />
  </a>
  <a href="https://github.com/DanielFiller30/ScriptManager">
    <img src="https://badge.fury.io/gh/DanielFiller30%2FScriptManager.svg" alt="Current GitHub version." />    
  </a>
  <img src="https://shields.io/badge/MacOS--9cf?logo=Apple&style=social" alt="Available for macOS" />
</p>

#

## Usage

Script Manager is a menu bar-tool to organize and simplify running a custom terminal-script:
- Add a new script and test it before saving (persistent storage)
- Full customizable settings to use your personal configurations
- Error-logging with custom directory
- Local notifications when script finished
- ...

### New features added in version 3.0 (v1.0.2)
- Fixed dismissing sheet to use ScriptManager with macOS Sonoma
- Added dynamic time calculation to monitor your progress
- The execution of multiple scripts in parallel has been enabled

### New features added in version 2.0 (v1.0.1)
- Output window for running script
- Change your main color from settings
- Add Tags to organize your scripts
- New UI-Design
- Keyboard-shortcuts for scripts
- Toggle to run tool by startup

<image src="Media/Screenshots/start_v2.png" width="250">    
<image src="Media/Screenshots/settings_v2.png" width="250">    

## Setup via Homebrew
To install the ScriptManager with Homebrew, you have to run the following command in your terminal:

`brew install danielfiller30/tap/scriptmanager`

Or `brew tap danielfiller30/tap` and then `brew install scriptmanager`.

To open the app, you have to trust the application in the system settings:
- Open settings on your Mac
- Navigate to **Privacy & Security**
- Under security, press allow to open the ScriptManager

## Setup via Xcode
To install and use your personal Script Manager via Xcode, you have to follow this steps:
- Clone this project to your local space
- Open the project in Xcode
- Run a build
- Copy the resulting program-file to your programs folder
> Xcode > Product > Show Build Folder in Finder

