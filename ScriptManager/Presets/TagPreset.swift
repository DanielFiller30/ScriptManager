//
//  TagPreset.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.07.24.
//


/// Presets for Tags to provide it to user
let TagPresets: [TagPreset] = [
    TagPreset(title: String(localized: "favorites"), color: AppColor.Favs, icon: "star"),
    TagPreset(title: String(localized: "archive"), color: AppColor.Archive, icon: "archivebox"),
    TagPreset(title: String(localized: "fixes"), color: AppColor.Fixes, icon: "hammer"),
    TagPreset(title: String(localized: "files"), color: AppColor.Files, icon: "doc.on.doc"),
    TagPreset(title: String(localized: "gitlab"), color: AppColor.GitLab, icon: "g.circle")
]
