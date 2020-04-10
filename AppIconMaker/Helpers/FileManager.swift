//
//  FileManager.swift
//  AppIconMaker
//
//  Created by Pasca Alberto, IT on 10/04/2020.
//  Copyright © 2020 albertopasca.it. All rights reserved.
//

import Cocoa

class FileManager {
    
    func chooseFolder( completionHandler completion: ((_ path: String) -> Void)? = nil ) {
        let dialog = NSOpenPanel();
        dialog.title = "Choose destination folder";
        
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = false;
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            if let result = dialog.url {
                if let completionCallback = completion {
                    let path = result.path
                    completionCallback(path)
                }
            }
        }
    }
    
}
