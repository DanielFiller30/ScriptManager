//
//  ScriptsListView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct ScriptsListView: View {
    @State private var vm = ScriptViewModel()
    @State private var vmTags = TagViewModel()
    @State private var showAddScriptModal = false
    @State private var showSearch = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.l) {
            Text("saved \(String(vm.scripts.count))")
                .fontWeight(.bold)
                .font(.system(size: FontSize.subTitle))
                .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                TagsListView()

                SearchbarView(vm: $vm, show: $showSearch)
            }
            
            if (vm.scripts.isEmpty) {
                VStack(alignment: .center) {
                    Spacer()
                    
                    if vm.tagHandler.selectedTag != nil {
                        // Tag is active
                        Image(systemName: "doc.text.magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 60)
                            .symbolEffect(.bounce, options: .nonRepeating)
                        
                        Text("empty-scripts-filter")
                            .font(.caption2)
                            .foregroundColor(AppColor.Creme)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            vmTags.setActiveTag(nil)
                        } label: {
                            HStack {
                                Spacer()
                                Text("remove-filter")
                                Spacer()
                                Image(systemName: "tag.slash")
                            }
                            .frame(width: 150)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .shadow(radius: 3, x: 1, y: 2)
                        }
                        .buttonStyle(.plain)
                        
                    } else if !vm.searchString.isEmpty {
                        // Search is active
                        Image(systemName: "doc.text.magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 60)
                            .symbolEffect(.bounce, options: .nonRepeating)
                        
                        Text("empty-scripts-search")
                            .font(.caption2)
                            .foregroundColor(AppColor.Creme)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            vm.searchString.removeAll()
                        } label: {
                            HStack {
                                Spacer()
                                Text("remove-search")
                                Spacer()
                                Image(systemName: "minus.magnifyingglass")
                            }
                            .frame(width: 150)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .shadow(radius: 3, x: 1, y: 2)
                        }
                        .buttonStyle(.plain)
                    } else {
                        // No scripts saved
                        Image(systemName: "doc.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 60)
                            .symbolEffect(.bounce, options: .nonRepeating)
                        
                        Text("empty-scripts")
                            .font(.caption2)
                            .foregroundColor(AppColor.Creme)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            vm.modalHandler.showModal(.ADD_SCRIPT)
                        } label: {
                            HStack {
                                Spacer()
                                Text("add-new-script")
                                Spacer()
                                Image(systemName: "doc")
                            }
                            .frame(width: 200)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .shadow(radius: 3, x: 1, y: 2)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    Spacer()
                }
            } else {
                ScrollView {
                    ForEach(vm.scripts) { script in
                        ScriptRowView(showAddScriptModal: $showAddScriptModal, script: script)
                            .padding(.horizontal, Spacing.l)
                            .padding(.bottom, Spacing.m)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, Spacing.xl + 4)
        .padding(.top, Spacing.m)
    }
}

struct ScriptsListView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptsListView()
            .background(.gray)
    }
}
