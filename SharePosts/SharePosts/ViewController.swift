//
//  ViewController.swift
//  SharePosts
//
//  Created by hyunji on 2020/11/27.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import SwiftyJSON

class ViewController: UIViewController, LoginButtonDelegate {
    
    var data : FBModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getPosts()
        
        if let token = AccessToken.current, !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start { (connection, result, error) in
                self.getPosts()
                print("request result = \(result)")
            }
        } else {
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
            view.addSubview(loginButton)
        }
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start { (connection, result, error) in
            self.getPosts()
            print("request result = \(result)")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // delegate method
    }
    
    func getPosts() {
        var request: GraphRequest?
        let accessToken = AccessToken.current?.tokenString
        let params = ["access_token" : accessToken ?? ""]
        request = GraphRequest.init(graphPath: "/171994119827578/posts/", parameters: params, httpMethod: HTTPMethod(rawValue: "GET"))
        
        request?.start(completionHandler: { (_, result, _) in
            let json = JSON.init(result ?? "") // Converting result into JSON using SwiftyJSON
            self.data = FBModel(attributes: json.dictionaryValue) //Mapping json into Model Class
            print(json)
            if let _ = self.data?.paging?.next {
                self.getNext()
            }
        })
    }
    
    func getNext() {
        var request: GraphRequest?
        let pageDict = Utility.dictionary(withQuery: /self.data?.paging?.next)
        request = GraphRequest.init(graphPath: "/171994119827578/posts/", parameters: pageDict, httpMethod: HTTPMethod(rawValue: "GET"))
        request?.start(completionHandler: { (_ , result, _) in
            let json = JSON.init(result ?? "")
            let newPosts = FBModel.init(attributes: json.dictionaryValue)
            let obj = self.data
            obj?.paging = newPosts.paging
            newPosts.posts?.forEach({ (post) in
                obj?.posts?.append(post)
            })
            self.data = obj
            print(json)
            if let _ = self.data?.paging?.next {
                self.getNext()
            }
            self.postDetail()
        })
    }
    
    
    func postDetail() {
        var request: GraphRequest?
        let accessToken = AccessToken.current?.tokenString
        let params = ["access_token" : accessToken ?? ""]
        request = GraphRequest.init(graphPath: "/" + /self.data?.posts?[31].id + "/attachments", parameters: params, httpMethod: HTTPMethod(rawValue: "GET"))
        request?.start(completionHandler: { (_, result, _) in
            let json = JSON.init(result ?? "")
            print(json)
        })
    }
    
    
}

