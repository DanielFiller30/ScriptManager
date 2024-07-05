//
//  TagsListView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 27.03.23.
//

import SwiftUI

struct TagsListView: View {
    @State private var vm = TagViewModel()
    @State private var showTags = true
    
    var body: some View {
        DisclosureGroup(isExpanded: $showTags) {
            VStack(alignment: .leading, spacing: Spacing.l) {
                ScrollView(.horizontal) {
                    HStack(spacing: Spacing.l) {
                        if (!vm.tags.isEmpty) {
                            ForEach(vm.tags, id: \.id) { tag in
                                if tag.id != EmptyTag.id {
                                    Button {
                                        withAnimation() {
                                            if tag.id == vm.selectedTag {
                                                vm.setActiveTag(nil)
                                            } else {
                                                vm.setActiveTag(tag.id)
                                            }
                                        }
                                    } label: {
                                        let badgeColor = try? ColorConverter.decodeColor(from: tag.badgeColor)
                                        
                                        BadgeView(
                                            color: badgeColor ?? AppColor.Primary,
                                            title: tag.name,
                                            active: tag.id == vm.selectedTag
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
                    .padding(.bottom, Spacing.l)
                }
            }
            .padding(.top, Spacing.xl)
        } label: {
            HStack(alignment: .center) {
                Text("tags-title")
                    .fontWeight(.bold)
                    .font(.system(size: FontSize.subTitle))
                
                Spacer()
                
                if let selectedTag = vm.selectedTag {
                    Button {
                        vm.showDeleteAlert(selectedTag)
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: IconSize.s, height: IconSize.s)
                            .foregroundColor(AppColor.Danger)
                            .help("hint-remove-tag")
                    }
                    .buttonStyle(.plain)
                }
                
                Button {
                    vm.modalHandler.showModal(.TAG)
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: IconSize.s, height: IconSize.s)
                        .foregroundColor(Color.white)
                        .help("add-new-tag")
                }
                .buttonStyle(.plain)
            }
            .padding(.leading, Spacing.m)
            .onTapGesture {
                withAnimation {
                    showTags.toggle()
                }
            }
        }
        .padding(.horizontal, Spacing.xl)
        .padding(.vertical, Spacing.l)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct TagsListView_Previews: PreviewProvider {
    static var previews: some View {
        TagsListView()
    }
}
