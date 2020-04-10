//
//  ViewController.swift
//  AppIconMaker
//
//  Created by Pasca Alberto, IT on 06/04/2020.
//  Copyright © 2020 albertopasca.it. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    // ---------------------------------------------------------------------------------------------
    // Outlets
    // ---------------------------------------------------------------------------------------------
    @IBOutlet weak var imgPreview: NSImageView!
    @IBOutlet weak var viewDrop: DropView!
    @IBOutlet weak var img1X: NSImageView!
    @IBOutlet weak var img2X: NSImageView!
    @IBOutlet weak var img3X: NSImageView!
    @IBOutlet weak var txtPath: NSTextField!
    
    // ---------------------------------------------------------------------------------------------
    // Helpers
    // ---------------------------------------------------------------------------------------------
    private lazy var fileManager    = FileManager()
    private lazy var imageConverter = ImageConverter()
    private lazy var viewModel      = ViewControllerModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
    }

    
    // ---------------------------------------------------------------------------------------------
    // Private
    // ---------------------------------------------------------------------------------------------

    private func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didReceiveFile),
            name: .kFileDroppedIn,
            object: nil
        )
    }
    
    private func refreshLayout() {
        DispatchQueue.main.async {
            if let folder = self.viewModel.destinationFolder {
                self.txtPath.stringValue = folder
            }
            if let preview = self.viewModel.imagePreview {
                self.imgPreview.image = preview
            }
            if let previews = self.viewModel.imagesPreview {
                self.img1X.image = previews[0]
                self.img2X.image = previews[1]
                self.img3X.image = previews[2]
            }
        }
    }
    
    
    // ---------------------------------------------------------------------------------------------
    // Notification
    // ---------------------------------------------------------------------------------------------

    @objc func didReceiveFile( file: Notification ) {
        if let image = viewModel.getImageForPreview(receivedFile: file),
            let name = viewModel.getImageName(receivedFile: file)
        {
            self.viewModel.imagePreview = image
            self.viewModel.imageData = ImageData(
                image: image,
                name: name
            )
        }

        self.refreshLayout()
    }
    

    // ---------------------------------------------------------------------------------------------
    // Actions
    // ---------------------------------------------------------------------------------------------

    @IBAction func didConvertPressed(_ sender: Any) {
        if let imageData = self.viewModel.imageData {
            imageConverter.convert(imageData: imageData) { images in
                self.viewModel.imagesPreview = images.map {
                    imageConverter.saveImages(imageData: $0, destinationFolder: URL(fileURLWithPath: self.viewModel.destinationFolder!)) { result in
                        if !result {
                            print( "Ops, something went wrong. Add a log to debug.")
                        }
                    }
                    return $0.image
                }
                self.refreshLayout()
            }
        }
    }
    
    @IBAction func didBrowsePressed(_ sender: Any) {
        fileManager.chooseFolder { path in
            self.viewModel.destinationFolder = path
            self.refreshLayout()
        }
    }
    
}
