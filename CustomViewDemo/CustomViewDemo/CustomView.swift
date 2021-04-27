//
//  CustomView.swift
//  CustomViewDemo
//
//  Created by hyunji on 2020/11/13.
//

import UIKit

class CustomView: UIView {
    @IBOutlet var customView: UIView!
    @IBOutlet var customLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
        print("coder")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        print("frame")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")
    }
    
    private func initialize() {
        Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)
        customView.frame = self.bounds
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(customView)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        customView.backgroundColor = .lightGray
        customLabel.textColor = .white
    }
}
