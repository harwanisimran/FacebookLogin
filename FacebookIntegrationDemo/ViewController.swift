//
//  ViewController.swift
//  FacebookIntegrationDemo
//
//  Created by webwerks on 12/07/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var labelStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fbLoginButton = FBSDKLoginButton()
        fbLoginButton.readPermissions = ["public_profile","email"]
        fbLoginButton.delegate = self
        fbLoginButton.center = self.view.center
        self.view.addSubview(fbLoginButton)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            labelStatus.text = error.localizedDescription
        }
        else if result.isCancelled {
            labelStatus.text = "User Cancelled log in"
        }
        else {
            labelStatus.text = "User Logged in"
            fetchProfile()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        labelStatus.text = "User Logged out"
    }

    func fetchProfile() {
    
        let request = GraphRequest.init(graphPath: "me", parameters: ["fields":"first_name,last_name, email, picture.type(large)"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        
        request.start({ (response, requestResult) in
            switch requestResult{
            case .success(let response):
                print(response.dictionaryValue!)
                print(response.dictionaryValue!["first_name"]!)
            case .failed(let error):
                print(error.localizedDescription)
            }
        })
    }
}

