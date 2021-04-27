//
//  ShareViewController.swift
//  share
//
//  Created by hyunji on 2020/11/27.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
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
    }

    override func configurationItems() -> [Any]! {
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
