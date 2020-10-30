//
//  CustomShareNavigationController.swift
//  Share
//
//  Created by hyunji on 2020/10/30.
//

import UIKit

@objc(CustomShareNavigationController)
class CustomShareNavigationController: UINavigationController {

    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.setViewControllers([CustomShareViewController()], animated: false)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
