//
//  ApplicationMenu.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation
import SwiftUI

class ApplicationMenu: NSObject {
    let menu = NSMenu()
    
    func createMenu() -> NSMenu {
        let mainView = MainView()
        let topView = NSHostingController(rootView: mainView)
        topView.view.frame.size = CGSize(width: 300, height: 450)
    
        let customMenuItem = NSMenuItem()
        customMenuItem.view = topView.view
        menu.addItem(customMenuItem)
        return menu
    }
}
