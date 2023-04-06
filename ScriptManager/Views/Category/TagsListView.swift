//
//  TagsListView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 27.03.23.
//

import SwiftUI

struct TagsListView: View {
    @StateObject var vmTag: TagViewModel
    @StateObject var vmScript: ScriptViewModel

    @ObservedObject var data = DataHandler.shared

    @State private var showDeleteAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.l) {
            HStack(alignment: .center) {
                Text("tags-title")
                    .fontWeight(.bold)
                    .font(.system(size: FontSize.subTitle))
                
                Spacer()
                
                if data.selectedTag != nil {
                    Button {
                        showDeleteAlert.toggle()
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: IconSize.s, height: IconSize.s)
                            .foregroundColor(AppColor.Danger)
                            .help("hint-remove-tag")
                    }
                    .buttonStyle(.plain)
                    .alert("delete-tag-title", isPresented: $showDeleteAlert) {
                        Button("cancel", role: .cancel) {}
                        Button("delete") {
                            // Remove tag to script connection
                            vmScript.removeTagFromScript(tagId: data.selectedTag)
                            // Delete the tag
                            vmTag.deleteTag()
                            data.selectedTag = nil
                        }
                    } message: {
                        Text("delete-tag-msg")
                    }
                }
                
                MenuSheetView(
                    hint: "add-new-tag",
                    sheetTitle: "add-new-tag",
                    onClick: {
                        vmTag.showAddTag.toggle()
                    },
                    onClose: {},
                    isPresented: $vmTag.showAddTag,
                    height: 270
                ) {
                    AddTagView(viewModel: vmTag)
                }
            }
            .padding(.bottom, Spacing.l)
            
            ScrollView(.horizontal) {
                HStack(spacing: Spacing.l) {
                    if (!data.tags.isEmpty) {
                        ForEach($data.tags, id: \.id) { $tag in
                            if tag.id != EmptyTag.id {
                                Button {
                                    withAnimation() {
                                        data.loadScripts()
                                        
                                        if tag.id == data.selectedTag {
                                            data.selectedTag = nil
                                        } else {
                                            data.selectedTag = tag.id
                                            vmScript.filterScripts(tag: tag)
                                        }
                                    }
                                } label: {
                                    BadgeView(
                                        color: ColorHandler.getDecodedColor(data: tag.badgeColor),
                                        title: tag.name,
                                        active: tag.id == data.selectedTag
                                    )
                                }
                                .buttonStyle(.plain)
                            }                            
                        }
                    } else {
                        Text("empty-tags")
                            .font(.system(size: FontSize.text))
                            .foregroundColor(AppColor.Creme)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                }
                .padding(.bottom, Spacing.xl)
            }
        }
        .padding(.horizontal, Spacing.xl)
        .padding(.top, Spacing.xl)
    }
}

struct TagsListView_Previews: PreviewProvider {
    static var previews: some View {
        TagsListView(vmTag: TagViewModel(), vmScript: ScriptViewModel())
    }
}
