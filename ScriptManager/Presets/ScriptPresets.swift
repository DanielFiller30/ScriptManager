//
//  ScriptPresets.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.07.24.
//

let ScriptPresets: [ScriptPreset] = [
    ScriptPreset(title: String(localized: "open-file"), icon: "doc.richtext", script: "open <path to file>;"),
    ScriptPreset(title: String(localized: "say-name"), icon: "waveform", script: "say <name>;"),
    ScriptPreset(title: String(localized: "clean-desktop"), icon: "wand.and.stars", script: "desktop_path=\"$HOME/Desktop\"; mkdir -p \"$desktop_path/Documents\" \"$desktop_path/Pictures\" \"$desktop_path/Videos\" \"$desktop_path/Other\"; for file in \"$desktop_path\"/*; do if [[ -f \"$file\" ]]; then extension=\"${file##*.}\"; case \"$extension\" in doc|rtf|docx|txt|pdf|xlsx) mv \"$file\" \"$desktop_path/Documents\"; ;; jpg|jpeg|png|gif|bmp) mv \"$file\" \"$desktop_path/Pictures\"; ;; mp4|avi|mkv|mov) mv \"$file\" \"$desktop_path/Videos\"; ;; *) mv \"$file\" \"$desktop_path/Other\"; ;; esac; fi; done; echo \"Files on your desktop have been sorted into folders.\""),
    ScriptPreset(title: String(localized: "countdown"), icon: "clock.arrow.circlepath", script: "sleep <time>; say 'Timer finished'"),
    ScriptPreset(title: String(localized: "git-pull"), icon: "arrow.down.circle.dotted", script: "cd <path to repo>; git pull;"),
    ScriptPreset(title: String(localized: "calculator"), icon: "x.squareroot", script: "bc", input: "2+2"),
    ScriptPreset(title: String(localized: "user-input"), icon: "person.bubble", script: "vared -p 'Enter your username: ' -c username; say $username", input: "<name>")
]
