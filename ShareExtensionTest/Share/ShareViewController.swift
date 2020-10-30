//
//  ShareViewController.swift
//  Share
//
//  Created by hyunji on 2020/10/30.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    // compose view에 텍스트를 입력할 때마다 호출됨
    // 텍스트를 입력하지 않았을 때 오른쪽 상단 버튼의 활성화 여부를 결정할 수 있다.
    // ShareViewController가 상속받고 있는 SLComposeServiceViewController
    override func isContentValid() -> Bool {
        return self.contentText.isEmpty == false
    }

    // Post 버튼을 눌렀을 때 호출
    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    // configuration item을 표시할 때 사용
    // [Any] 배열 안에 SLComposeSheetConfigurationItem타입이 들어감
    override func configurationItems() -> [Any]! {
        let item = SLComposeSheetConfigurationItem()!
        item.title = "Title"
        item.value = "RosePurple"
        item.tapHandler = {}
        
        return [item]
    }

}
