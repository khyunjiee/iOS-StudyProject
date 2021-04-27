//
//  ViewController.swift
//  SnsShareExtension
//
//  Created by hyunji on 2020/12/15.
//

import UIKit

//var image: UIImage = UIImage()

class ViewController: UIViewController {
    @IBOutlet var imgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        let savedata = UserDefaults.init(suiteName: "group.com.hyunji.SnsShareExtension")
        if savedata?.value(forKey: "imgView") != nil {
            print("Available data")
//            let data = ((savedata?.value(forKey: "image") as! NSDictionary).value(forKey: "imgView") as! UIView)
            let view = savedata?.value(forKey: "imgView")
            self.imgView = view as! UIView
        }
    }
}

