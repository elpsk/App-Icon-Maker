//
//  MainWindow.swift
//  AppIconMaker
//
//  Created by Pasca Alberto, IT on 27/12/17.
//  Copyright © 2017 Pasca Alberto, IT. All rights reserved.
//

import Cocoa

class MainWindow: NSWindowController {
    
    var vctrl : ViewController?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        setupCustomWindow()

        if let titlebarController = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("titlebarViewController")) as? NSTitlebarAccessoryViewController {
            titlebarController.layoutAttribute = .right
            self.window?.addTitlebarAccessoryViewController(titlebarController)
        }

        vctrl = self.contentViewController as? ViewController
    }

    //
    // more details here:
    // https://www.albertopasca.it/whiletrue/swift-macos-how-to-make-cool-desktop-apps-using-cocoa/
    //
    func setupCustomWindow() {
        self.smartWindow()
        self.activateWindowDrag()
    }

}
