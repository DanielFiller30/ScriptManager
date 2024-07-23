//
//  SettingsBackupView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.07.24.
//

import SwiftUI

struct SettingsBackupView: View {
    private var vm = BackupViewModel()
    
    var body: some View {
        HStack() {
            Text("export-info")
                .font(.caption)
            
            Spacer()
        }
        .padding(.top, Spacing.l)
        
        Button {
            vm.exportUserdate()
        } label: {
            HStack(alignment: .center) {
                Spacer()
                Text("export-data")
                Spacer()
                Image(systemName: "square.and.arrow.up")
            }
            .padding(.horizontal)
            .padding(.vertical, Spacing.m)
            .background(.ultraThickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
        
        HStack() {
            Text("import-info")
                .font(.caption)
            
            Spacer()
        }
        .padding(.top, Spacing.l)
        
        Button {
            vm.importUserdate()
        } label: {
            HStack(alignment: .center) {
                Spacer()
                Text("import-data")
                Spacer()
                Image(systemName: "square.and.arrow.down")
            }
            .padding(.horizontal)
            .padding(.vertical, Spacing.m)
            .background(.ultraThickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
        .padding(.bottom, Spacing.l)
    }
}
