//
//  LoginViewController.swift
//  GoChat
//
//  Created by 鄭薇 on 2016/12/4.
//  Copyright © 2016年 LilyCheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var Enterbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Set border color and width
        Enterbutton.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print(FIRAuth.auth()?.currentUser)
//        FIRAuth.auth()?.addStateDidChangeListener({(auth:FIRAuth, user:FIRUser?)in
//            if user !=nil{
//                print(user)
//                Helper.helper.switchToNavigationViewController()
//            }else{
//                print("Unauthorized")
//            }
//        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EnterChatRoom(_ sender: Any) {
        print("enter the chat room successfully")
        //switch view by setting navigation controller as root view controller
        Helper.helper.EnterChatRoomEveryone()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
