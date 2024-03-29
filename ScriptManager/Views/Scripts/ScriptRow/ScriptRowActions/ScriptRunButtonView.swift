//
//  ScriptRunButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI
import AnyCodable

struct ScriptRunButtonView: View {
    let viewModel: ScriptViewModel
    let scriptHandler: ScriptHandler = ScriptHandler()
    
    var script: Script
    
    @State var showRunPopover: Bool = false
    
    var body: some View {
        if (viewModel.isRunning && viewModel.runningScript.contains(where: { $0.id == script.id })) {
            if let time = viewModel.sciptTimes.first(where: { $0.scriptId == script.id })?.remainingTime {
                Text(time)
                    .font(.caption2)
                    .padding(Spacing.l)
                    .background(AppColor.Light)
                    .cornerRadius(10.0)
            } else {
                ProgressView()
                    .frame(width: IconSize.s, height: IconSize.s)
                    .scaleEffect(0.5)
                    .padding(Spacing.l)
                    .background(AppColor.Light)
                    .clipShape(Circle())
            }
        } else {
            Button {
                showRunPopover.toggle()
            } label: {
                Image(systemName: "play")
                    .resizable()
                    .frame(width: IconSize.s, height: IconSize.s)
                    .padding(Spacing.l)
                    .background(AppColor.Light)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            .popover(isPresented: $showRunPopover, arrowEdge: .bottom) {
                VStack(alignment: .center, spacing: Spacing.m) {
                    Button {
                        showRunPopover.toggle()
                        viewModel.runningScript.append(script)
                        viewModel.runScript(showOutput: false, scriptId: script.id)
                    } label: {
                        HStack(alignment: .center) {
                            Spacer()
                            
                            Text("script-run")
                                .font(.system(size: FontSize.text))
                            
                            Spacer()
                            
                            Image(systemName: "play")
                                .resizable()
                                .frame(width: IconSize.s, height: IconSize.s)
                        }
                        .frame(width: 150)
                        .padding(.horizontal, Spacing.l)
                        .padding(.vertical, Spacing.l)
                        .background(AppColor.Dark)
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        showRunPopover.toggle()
                        viewModel.runningScript.append(script)
                        viewModel.runScript(showOutput: true, scriptId: script.id)
                    } label: {
                        HStack(alignment: .center) {
                            Spacer()
                            
                            Text("script-run-output")
                                .font(.system(size: FontSize.text))
                            
                            Spacer()
                            
                            Image(systemName: "play.display")
                                .resizable()
                                .frame(width: IconSize.s, height: IconSize.s)
                        }
                        .frame(width: 150)
                        .padding(.horizontal, Spacing.l)
                        .padding(.vertical, Spacing.l)
                        .background(AppColor.Dark)
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.all, Spacing.m)
                .background(AppColor.AppBg)
            }
        }
    }
}

struct ScriptRunButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptRunButtonView(viewModel: ScriptViewModel(), script: DefaultScript)
    }
}
