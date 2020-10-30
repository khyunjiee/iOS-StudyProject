//
//  CustomShareViewController.swift
//  Share
//
//  Created by hyunji on 2020/10/30.
//

import UIKit

class CustomShareViewController: UIViewController {
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "값을 입력해주세요"
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center

        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        super.view.backgroundColor = .systemGray6
        setupNavBar()
        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            textField.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "커스텀 뷰"
        
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.setLeftBarButton(cancel, animated: false)
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        self.navigationItem.setRightBarButton(done, animated: false)
    }
    
    @objc private func cancelAction() {
        let error = NSError(domain: "com.hyunji.ShareExtensionTest.Share", code: 0, userInfo: [NSLocalizedDescriptionKey: "An error description"])
        extensionContext?.cancelRequest(withError: error)
    }
    
    @objc private func doneAction() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
