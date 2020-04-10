//
//  ViewControllerModel.swift
//  AppIconMaker
//
//  Created by Pasca Alberto, IT on 10/04/2020.
//  Copyright © 2020 albertopasca.it. All rights reserved.
//

import Cocoa

class ViewControllerModel {

    var imageData        : ImageData?    = nil
    var destinationFolder: String?       = nil
    var imagePreview     : NSImage?      = nil
    var imagesPreview    : [NSImage]?    = nil

    // ---------------------------------------------------------------------------------------------

    private func isReceivedFileValid( receivedFile : Notification? ) -> Bool {
        guard let receivedFile = receivedFile else { return false }
        guard let _ = receivedFile.userInfo else { return false }

        guard let type = receivedFile.object as? String, type == "image" else {
            return false
        }
        
        return true
    }

    // ---------------------------------------------------------------------------------------------

    func getImageForPreview( receivedFile : Notification? ) -> NSImage? {
        if !isReceivedFileValid(receivedFile: receivedFile) { return nil }
        if let image = getImagePath(receivedFile: receivedFile) {
            return NSImage(contentsOfFile: image)
        }
        return nil
    }
    
    func getImagePath( receivedFile : Notification? ) -> String? {
        if !isReceivedFileValid(receivedFile: receivedFile) { return nil }
        guard let fileName = receivedFile!.userInfo!["file"] as? String else { return nil }
        return fileName
    }

    func getImageName( receivedFile : Notification? ) -> String? {
        if !isReceivedFileValid(receivedFile: receivedFile) { return nil }
        guard let fileName = receivedFile!.userInfo!["file"] as? String else { return nil }
        return fileName.components(separatedBy: "/").last
    }

}
