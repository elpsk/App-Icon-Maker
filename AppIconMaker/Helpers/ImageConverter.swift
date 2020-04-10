//
//  ImageConverter.swift
//  AppIconMaker
//
//  Created by Pasca Alberto, IT on 10/04/2020.
//  Copyright © 2020 albertopasca.it. All rights reserved.
//

import Cocoa

class ImageConverter {
    
    private func reducedSize( initialSize: NSSize, for type: ImageSize ) -> NSSize {
        if type == .x3 { return initialSize }
        return NSSize(width: Int(initialSize.width / 2), height: Int(initialSize.height / 2))
    }

    private func formattedName( imageName: String, for type: ImageSize ) -> String {
        let rawName = (imageName as NSString).deletingPathExtension
        return "\(rawName)@\(type.rawValue)x.png"
    }

    // ---------------------------------------------------------------------------------------------

    func convert( imageData: ImageData, completionHandler completion: ((_ images: [ImageData]) -> Void)) {
        let sizeX3 = imageData.image.size
        let sizeX2 = reducedSize(initialSize: sizeX3, for: .x2)
        let sizeX1 = reducedSize(initialSize: sizeX2, for: .x1)

        let imageX3: NSImage  = imageData.image
        let imageX2: NSImage! = imageData.image.resized(to: sizeX2)
        let imageX1: NSImage! = imageData.image.resized(to: sizeX1)

        let images: [ImageData] = [
            ImageData(image: imageX1, name: formattedName(imageName: imageData.name, for: .x1)),
            ImageData(image: imageX2, name: formattedName(imageName: imageData.name, for: .x2)),
            ImageData(image: imageX3, name: formattedName(imageName: imageData.name, for: .x3))
        ]

        completion(images)
    }

    func saveImages( imageData: ImageData, destinationFolder: URL, completionHandler completion: ((_ status: Bool) -> Void)) {
        completion(
            imageData.image.pngWrite(to: destinationFolder.appendingPathComponent("\(imageData.name)"))
        )
    }
    
}
