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
                    }
                }
                .padding(.bottom, Spacing.l + 5)
            }
        }
        .padding(.horizontal, Spacing.l)
    }
}

struct TagsListView_Previews: PreviewProvider {
    static var previews: some View {
        TagsListView()
    }
}
