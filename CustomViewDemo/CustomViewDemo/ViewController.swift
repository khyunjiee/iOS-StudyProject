//
//  ViewController.swift
//  CustomViewDemo
//
//  Created by hyunji on 2020/11/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func show(_ sender: Any) {
        let customView = CustomView(frame: CGRect(x: 105, y: 200, width: 200, height: 350))
        view.addSubview(customView)
    }
}

