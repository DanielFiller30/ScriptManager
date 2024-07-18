//
//  WelcomeView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct WelcomeView: View {
    let close: () -> Void
    @Binding var hideWelcomeScreen: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25)
                
                Text("ScriptManager")
                    .font(.headline)
                
                Text("version")
                
                Spacer()
            }
            .padding(.bottom, Spacing.xl)
            
            Text("welcome-title")
                .font(.system(size: FontSize.title))
                .fontWeight(.bold)
            
            Text("welcome-info")
                .font(.caption)
                .padding(.bottom, Spacing.l)
                .foregroundColor(AppColor.Creme)
            
            Divider()
                .padding(.vertical, 10)
            
            // Features
            Text("features-title")
                .font(.headline)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "doc")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .padding(10)
                            .background(.ultraThickMaterial)
                            .clipShape(.circle)
                            .shadow(radius: 3, x: 1, y: 2)

                        Text("scripts-info")
                            .font(.caption)
                            .frame(maxWidth: 200, maxHeight: 40)
                            .lineLimit(2)
                    }
                    
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "tag")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .padding(10)
                            .background(.ultraThickMaterial)
                            .clipShape(.circle)
                            .shadow(radius: 3, x: 1, y: 2)

                        Text("tags-info")
                            .font(.caption)
                            .frame(maxWidth: 200, maxHeight: 40)
                            .lineLimit(2)
                    }
                    
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "command")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .padding(10)
                            .background(.ultraThickMaterial)
                            .clipShape(.circle)
                            .shadow(radius: 3, x: 1, y: 2)

                        Text("shortcuts-info")
                            .font(.caption)
                            .frame(maxWidth: 200, maxHeight: 40)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "bell.badge")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .padding(10)
                            .background(.ultraThickMaterial)
                            .clipShape(.circle)
                            .shadow(radius: 3, x: 1, y: 2)

                        Text("notification-info")
                            .font(.caption)
                            .frame(maxWidth: 200, maxHeight: 40)
                            .lineLimit(2)
                    }
                    
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "doc.text.magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .padding(10)
                            .background(.ultraThickMaterial)
                            .clipShape(.circle)
                            .shadow(radius: 3, x: 1, y: 2)

                        Text("scripts-details-info")
                            .font(.caption)
                            .frame(maxWidth: 200, maxHeight: 40)
                            .lineLimit(2)
                    }
                    
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "star.square.on.square")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .padding(10)
                            .background(.ultraThickMaterial)
                            .clipShape(.circle)
                            .shadow(radius: 3, x: 1, y: 2)

                        Text("extras-info")
                            .font(.caption)
                            .frame(maxWidth: 200, maxHeight: 40)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
            }
            
            Divider()
                .padding(.vertical, 10)

            // Instructions
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("instructions-title")
                        .font(.headline)
                    
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .padding(10)
                            .background(.ultraThickMaterial)
                            .clipShape(.circle)
                            .shadow(radius: 3, x: 1, y: 2)

                        Text("add-script-tag-instruction")
                            .font(.caption)
                            .lineLimit(3)
                    }
                    
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "gear")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .padding(10)
                            .background(.ultraThickMaterial)
                            .clipShape(.circle)
                            .shadow(radius: 3, x: 1, y: 2)

                        Text("settings-instruction")
                            .font(.caption)
                            .lineLimit(3)
                    }
                    
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "play")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .padding(10)
                            .background(.ultraThickMaterial)
                            .clipShape(.circle)
                            .shadow(radius: 3, x: 1, y: 2)

                        Text("play-instruction")
                            .font(.caption)
                            .frame(maxWidth: 220, maxHeight: 60)
                            .lineLimit(3)
                    }
                }
                .padding(.trailing, 30)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("states-title")
                        .font(.headline)
                    
                    HStack(alignment: .center) {
                        HStack(alignment: .center, spacing: 15) {
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(AppColor.Success)
                                .frame(height: 10)
                                .padding(10)
                                .background(.ultraThickMaterial)
                                .clipShape(.circle)
                                .shadow(radius: 3, x: 1, y: 2)

                            Text("success")
                                .font(.caption)
                        }
                        .padding(.trailing, 25)
                                                
                        HStack(alignment: .center, spacing: 15) {
                            Image(systemName: "xmark")
                                .resizable()
                                .foregroundColor(AppColor.Warning)
                                .scaledToFit()
                                .frame(height: 10)
                                .padding(10)
                                .background(.ultraThickMaterial)
                                .clipShape(.circle)
                                .shadow(radius: 3, x: 1, y: 2)

                            Text("interrupted")
                                .font(.caption)
                        }
                    }
                    
                    HStack(alignment: .center) {
                        HStack(alignment: .center, spacing: 15) {
                            Image(systemName: "xmark")
                                .resizable()
                                .foregroundColor(AppColor.Danger)
                                .scaledToFit()
                                .frame(height: 10)
                                .padding(10)
                                .background(.ultraThickMaterial)
                                .clipShape(.circle)
                                .shadow(radius: 3, x: 1, y: 2)

                            Text("failed")
                                .font(.caption)
                        }
                        .padding(.trailing, 25)
                        
                        HStack(alignment: .center, spacing: 15) {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(height: 10)
                                .padding(10)
                                .background(AppColor.Danger)
                                .clipShape(.circle)
                                .shadow(radius: 3, x: 1, y: 2)

                            Text("failed-logs")
                                .font(.caption)
                        }
                    }
                }
                
                Spacer()
            }
            
            Divider()
                .padding(.vertical, 10)
            
            Spacer()
            
            HStack(alignment: .center) {
                Text("welcome-toggle")
                    .font(.system(size: FontSize.text))
                
                Toggle("", isOn: $hideWelcomeScreen)
                
                Spacer()
                
                Button {
                    close()
                } label: {
                    HStack(alignment: .center) {
                        Text("welcome-close")
                            .padding(.trailing, Spacing.l)
                        
                        Image(systemName: "arrow.right.circle")
                            .resizable()
                            .frame(width: IconSize.m, height: IconSize.m)
                            .foregroundColor(.white)
                        
                    }
                    .padding(Spacing.l)
                    .background(AppColor.Primary)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .shadow(radius: 3, x: 1, y: 2)
                }
                .buttonStyle(.plain)
            }
            
        }
        .frame(width: 600, height: 550)
        .padding(Spacing.xl)
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(close: {}, hideWelcomeScreen: .constant(false))
    }
}
