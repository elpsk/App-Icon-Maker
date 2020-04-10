//
//  NSWIndowController.swift
//  AppIconMaker
//
//  Created by Pasca Alberto, IT on 11/04/18.
//  Copyright © 2018 Pasca Alberto, IT. All rights reserved.
//

import Cocoa

//
// more details here:
// https://www.albertopasca.it/whiletrue/swift-macos-how-to-make-cool-desktop-apps-using-cocoa/
//
extension NSWindowController {
    
    func smartWindow() {
        self.window?.styleMask.insert(NSWindow.StyleMask.unifiedTitleAndToolbar)
        self.window?.styleMask.insert(NSWindow.StyleMask.fullSizeContentView)
        self.window?.styleMask.insert(NSWindow.StyleMask.titled)

        self.window?.toolbar?.isVisible = false

        self.window?.titleVisibility = .hidden
        self.window?.titlebarAppearsTransparent = true
    }
    
    func activateWindowDrag() {
        self.window?.isMovableByWindowBackground = true
    }
    
}
