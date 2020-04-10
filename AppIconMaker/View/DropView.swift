//
//  DropView.swift
//  AppIconMaker
//
//  Created by Pasca Alberto, IT on 27/12/17.
//  Copyright © 2017 Pasca Alberto, IT. All rights reserved.
//

import Cocoa

class DropView: NSStackView {

    var filePath: String?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clear.cgColor
        self.layer?.cornerRadius = 10

        registerForDraggedTypes([NSPasteboard.PasteboardType.URL, NSPasteboard.PasteboardType.fileURL])
    }

    fileprivate func checkExtension(_ drag: NSDraggingInfo) -> Bool {
        guard let board = drag.draggingPasteboard.propertyList(forType: .kNSFilenamesPboardType) as? NSArray,
            let path = board[0] as? String
            else { return false }
        
        let suffix = URL(fileURLWithPath: path).pathExtension
        
        return Constants.validExtensions.filter { ext in ext.hasSuffix(suffix) }.count > 0
    }

    // -------------------------------------------------------------------------

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(sender) == true {
            return .copy
        } else {
            return NSDragOperation()
        }
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) { }
    override func draggingEnded (_ sender: NSDraggingInfo ) { }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let pasteboard = sender.draggingPasteboard.propertyList(forType: .kNSFilenamesPboardType) as? NSArray,
            let path = pasteboard[0] as? String
            else { return false }

        self.filePath = path

        NotificationCenter.default.post(name: .kFileDroppedIn, object: self.identifier, userInfo: ["file": path])

        return true
    }
}


