//
//  ShareViewController.swift
//  SnsShare
//
//  Created by hyunji on 2020/12/15.
//

import UIKit
import Social
import Photos
import MobileCoreServices

@objc(ShareExtensionViewController)
class ShareViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .cyan
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var captureButton: UIButton = {
        let button = UIButton()
        button.setTitle("capture", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5
        setupNavBar()
        setupUI()
        loadPreviewImage()
    }
    
    func loadPreviewImage(){
        
        //        print("💕loadPreviewImage")
        //
        //        if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
        //            if let itemProvider = inputItem.attachments?.first {
        //                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeJPEG as String) {
        //                    itemProvider.loadItem(forTypeIdentifier: kUTTypeJPEG as String) { [unowned self] (imageData, error) in
        //                        if let item = imageData as? Data {
        //                            print("this is screenshot \(item)")
        //                            self.imageView.image = UIImage(data: item)
        //                        }
        //                    }
        //                }
        //            }
        //        }
        
        let inputItem: NSExtensionItem = self.extensionContext?.inputItems[0] as! NSExtensionItem
        let itemProvider = inputItem.attachments![0] as! NSItemProvider
        if (itemProvider.hasItemConformingToTypeIdentifier("public.url")) {
            itemProvider.loadPreviewImage(options: nil, completionHandler: { (item, error) in
                if let image = item as? UIImage {
                    self.imageView.image = image
                    if let data = image.pngData() {
                        print("data💝", data)
                    }
                }
            })
        }
        
        
        
    }
    
    func takeWholeScreenshot() {
        UIGraphicsBeginImageContextWithOptions(
            self.view.bounds.size,
            false,
            UIScreen.main.scale)
        
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //        self.imageView.image = screenshot
        UIImageWriteToSavedPhotosAlbum(screenshot, self, #selector(imageWasSaved(_:error:context:)), nil)
    }
    
    @objc func imageWasSaved(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        print("Image was saved in the photo gallery")
    }
    
    func getImage() {
        if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeJPEG as String) {
                    itemProvider.loadItem(forTypeIdentifier: kUTTypeJPEG as String) { [unowned self] (imageData, error) in
                        if let item = imageData as? Data {
                            print("this is screenshot \(item)")
                            self.imageView.image = UIImage(data: item)
                        }
                    }
                }
            }
        }
    }
    
}

// MARK: UI Setup
extension ShareViewController {
    
    private func setupNavBar() {
        self.navigationItem.title = "My Share app"
        
        let itemCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.setLeftBarButton(itemCancel, animated: false)
        
        let itemDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        self.navigationItem.setRightBarButton(itemDone, animated: false)
    }
    
    @objc private func cancelAction () {
        let error = NSError(domain: "damdam.shareEx2.Share", code: 0, userInfo: [NSLocalizedDescriptionKey: "An error description"])
        extensionContext?.cancelRequest(withError: error)
    }
    
    @objc private func doneAction() {
        print("doneAction🔥")
        takeWholeScreenshot()
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    private func setupUI(){
        self.view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}


@objc(CustomShareNavigationController)
class CustomShareNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setViewControllers([ShareViewController()], animated: false)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
