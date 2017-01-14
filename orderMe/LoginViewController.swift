//
//  LoginViewController.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 12/30/16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit

import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController {
    
    var cameFromReserveOrOrderProcess = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        AccessToken.refreshCurrentToken { (accessToken, error) in
            if AccessToken.current != nil {
                self.loginToServerAfterFacebook()
            }
            else
            {
                let loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
                loginButton.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height * 0.9)
                loginButton.delegate = self
                self.view.addSubview(loginButton)
            }
        }
    }
    
    func loginToServerAfterFacebook() {
        guard let accessToken = AccessToken.current?.authenticationToken else { return }
        NetworkClient.login(accessToken: accessToken) { (user, error) in
            SingleTone.shareInstance.user = user
            self.successLogin()
        }
    }
    
    @IBAction func logInLaterButton(_ sender: AnyObject) {
        successLogin()
    }
    
}


// MARK LoginButtonDelegate
extension LoginViewController : LoginButtonDelegate{
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult){
        switch result {
        case .success(_ , _ , _):
            self.loginToServerAfterFacebook()
            break
        default :
            
            break
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton){
        print("User logged out")
    }
}


//MARK : results of login
extension LoginViewController {
    func errorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Sorry, some error occured. Try again later", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func successLogin() {
        switch cameFromReserveOrOrderProcess {
        case false:
            if let MainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as? MyTabBarController {
                MainTabBarController.selectedIndex = 1
                self.navigationController!.pushViewController(MainTabBarController, animated: true)
            }
            break
        case true :
            cameFromReserveOrOrderProcess = false
            _ = self.navigationController?.popViewController(animated: true)
            break
        }
    }
}
