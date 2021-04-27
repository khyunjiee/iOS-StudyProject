//
//  ShareViewController.swift
//  ShareShare
//
//  Created by hyunji on 2020/11/14.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.

        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = item.attachments?.first as? NSItemProvider {
                print("first = , \(itemProvider)")
                if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                    itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil) { (url, error) in
                        if let shareURL = url as? NSURL {
                            print(shareURL)
                        }
                        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                    }
                }
            }
        }
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        var item = SLComposeSheetConfigurationItem()
        item?.title = "Configure something"

        item?.tapHandler = {
            let alert = UIAlertController(title: nil, message: "Configure", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }

        return [item]
    }

}
