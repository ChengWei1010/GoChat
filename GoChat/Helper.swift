//
//  Helper.swift
//  GoChat
//
//  Created by 鄭薇 on 2016/12/4.
//  Copyright © 2016年 LilyCheng. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class Helper{
    static let helper = Helper()
    func EnterChatRoomEveryone() {
        //switch view by setting navigation controller as root view controller
        FIRAuth.auth()?.signInAnonymously(completion: {(user, error) in
            if error != nil{
                print("error" + error!.localizedDescription)
                return
            }
            print("logged in with uId:" + user!.uid)
            
            //print("logged in with roomId" + room_Id)
            //var _roomId = 00000
            
            //Create a main storyboard instance
            let storyboard = UIStoryboard(name : "Main", bundle: nil)
            
            //From main storyboard instantiate a navigation controller
            let naviVC = storyboard.instantiateViewController(withIdentifier:"NavigationVC")as!UINavigationController
            
            //Get the app delegate
            let appDelegate = UIApplication.shared.delegate as!AppDelegate
            
            //Set Navigation Conteoller as root view controller
            appDelegate.window?.rootViewController = naviVC
        })
    }
    public func switchToNavigationViewController(){
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let naviVC = storyboard.instantiateViewController(withIdentifier:"NavigationVC")
        let appDelegate = UIApplication.shared.delegate as!AppDelegate
        appDelegate.window?.rootViewController = naviVC
    }
}
