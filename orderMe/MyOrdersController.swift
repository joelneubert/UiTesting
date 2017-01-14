//
//  MyOrdersController.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 6/4/16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class MyOrdersController: UIViewController {
    
    var orders : [Order] = []
    
    @IBOutlet weak var ordersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTableView.dataSource = self
        if SingleTone.shareInstance.user != nil {
            loadData()
            SingleTone.shareInstance.newOrder = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let loginLogoutButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        let facebookButton = UIBarButtonItem(customView: loginLogoutButton)
        self.navigationItem.setRightBarButton(facebookButton, animated: false)
        loginLogoutButton.delegate = self
        if SingleTone.shareInstance.user == nil {
            showAlertWithLoginFacebookOption()
        }
    }
    
    func loadData(){
        NetworkClient.getOrders { (orders, error) in
            if error != nil {
                return
            }
            if let myOrders = orders {
                self.orders = myOrders
                self.ordersTableView.reloadData()
            }
        }
        ordersTableView.reloadData()
    }
    
    func showAlertWithLoginFacebookOption() {
        let alertController = UIAlertController(title: "You did not login", message: "You need to login for viewing your orders", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction!) in
            self.tabBarController?.selectedIndex = 1
        }
        let toFacebookAction = UIAlertAction(title: "Login", style: .default) { (action: UIAlertAction) in
            _ = self.navigationController?.popToRootViewController(animated: true)
            if let LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "RootNaviVC") as? UINavigationController {
                //self.navigationController?.viewControllers.removeAll()
                self.present(LoginViewController, animated: true) {
                    SingleTone.shareInstance.user = nil
                }
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(toFacebookAction)
        self.present(alertController, animated: true, completion:nil)
    }
}


// Mark : UITableViewDataSource
extension MyOrdersController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myOrderCell",for: indexPath) as? myOrderCell {
            
            // firstly, display last order
            let numbetOfOrder = orders.count - 1 - (indexPath as NSIndexPath).row
            // check the correctness of number of order
            guard numbetOfOrder < orders.count else { return UITableViewCell() }
            let order = orders[numbetOfOrder]
            
            cell.placeNameLabel.text = order.place?.name
            guard let orderCreated = order.created,
                let orderSum = order.sum  else { return UITableViewCell() }
            cell.dataLabel.text = orderCreated.makeDateRepresentation()
            cell.sumLabel.text = orderSum.description
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension MyOrdersController : LoginButtonDelegate{
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
        _ = self.navigationController?.popToRootViewController(animated: true)
        if let LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "RootNaviVC") as? UINavigationController {
            //self.navigationController?.viewControllers.removeAll()
            self.present(LoginViewController, animated: true) {
                SingleTone.shareInstance.user = nil
            }
        }
    }
    
    func loginToServerAfterFacebook() {
        guard let accessToken = AccessToken.current?.authenticationToken else { return }
        NetworkClient.login(accessToken: accessToken) { (user, error) in
            SingleTone.shareInstance.user = user
        }
    }
}

//MARK: NewOrderProtocol
extension MyOrdersController : NewOrderProtocol {
    func addNewOrder(order: Order) {
        self.orders.append(order)
        self.ordersTableView.reloadData()
    }
}
