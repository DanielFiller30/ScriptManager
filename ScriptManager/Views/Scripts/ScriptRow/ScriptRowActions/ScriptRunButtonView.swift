//
//  ScriptRunButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct ScriptRunButtonView: View {
    let viewModel: ScriptViewModel
    let scriptHandler: ScriptHandler = ScriptHandler()
    
    @Binding var script: Script
    @Binding var isRunning: Bool
    
    @State var activeId: UUID? = nil
    @State var showRunPopover: Bool = false
    
    var body: some View {
        if (isRunning && activeId == script.id) {
            ProgressView()
                .frame(width: IconSize.s, height: IconSize.s)
                .scaleEffect(0.5)
                .padding(Spacing.l)
                .background(AppColor.Light)
                .clipShape(Circle())
            
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
            .disabled(isRunning)
            .popover(isPresented: $showRunPopover, arrowEdge: .bottom) {
                VStack(alignment: .center, spacing: Spacing.m) {
                    Button {
                        showRunPopover.toggle()
                        
                        Task {
                            await runScript(showOutput: false)
                        }
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
                        
                        Task {
                            await runScript(showOutput: true)
                        }
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
    
    private func runScript(showOutput: Bool) async {
        activeId = script.id
        isRunning = true
        
        if showOutput {
            openOutputWindow()
        }
        
        let success = await scriptHandler.runScript(script, test: false)
        
        DispatchQueue.main.async {
            self.script.success = success
            
            withAnimation() {
                // Show state-button
                self.script.finished = true
            }
            
            self.script.lastRun = Date.now
        }        
        
        viewModel.updateSavedScripts()
        
        isRunning = false
        
        viewModel.loadSettings()
    }
    
    private func openOutputWindow() {
        DispatchQueue.main.async {
            let window = NSWindow()
            let contentView = OutputWindowView(scriptHandler: scriptHandler)
            window.contentViewController = NSHostingController(rootView: contentView)
            window.styleMask = [.titled, .resizable, .closable, .miniaturizable]
            window.center()
            window.title = "Output"
            window.isReleasedWhenClosed = false
            window.orderFrontRegardless()
            window.makeKeyAndOrderFront(nil)
        }
    }

}

struct ScriptRunButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptRunButtonView(viewModel: ScriptViewModel(), script: .constant(DefaultScript), isRunning: .constant(false))
    }
}
