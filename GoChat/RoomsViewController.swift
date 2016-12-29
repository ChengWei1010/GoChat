//
//  RoomsViewController.swift
//  GoChat
//
//  Created by 鄭薇 on 2016/12/19.
//  Copyright © 2016年 LilyCheng. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseDatabase

enum Section: Int {
    case createNewChannelSection = 0
    case currentChannelsSection
}


class RoomsViewController: UIViewController {
    
    // MARK: Properties
    var senderDisplayName: String?
    var newRoomTextField: UITextField?

    private var roomRefHandle: FIRDatabaseHandle?
    private var rooms: [Room] = []  //本意是在tableview上列出所有已存在房間
    
    private lazy var roomRef: FIRDatabaseReference = FIRDatabase.database().reference().child("rooms")
    
    // MARK: TextField
    @IBOutlet weak var InputRoomName: UITextField!    
    @IBOutlet weak var InputRoomNum: UITextField!
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = senderDisplayName
        observeRooms()
    }
    deinit {
        if let refHandle = roomRefHandle {
            roomRef.removeObserver(withHandle: refHandle)
        }
    }
    
    // MARK :Actions
    @IBAction func Logout(_ sender: Any) {
        print("User logged out")
        do{
            try FIRAuth.auth()?.signOut()
        }catch let error{
            print(error)
        }
        print(FIRAuth.auth()?.currentUser)
        //Create a main storyboard instance
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        
        //From main storyboard instantiate a View controller
        let LoginVC = storyboard.instantiateViewController(withIdentifier:"LoginVC")as!LoginViewController
        //Get the app delegate
        let appDelegate = UIApplication.shared.delegate as!AppDelegate
        //Set Login Conteoller as root view controller
        appDelegate.window?.rootViewController = LoginVC
    }
    
    @IBAction func NewRoom(_ sender: Any) {
        let randomRoomNum:UInt32 = arc4random_uniform(9999)         //亂數產生四位數房號
        let newRoomRef = roomRef.child(String(randomRoomNum))       //定義firebase裡的reference
        //原：let newChannelRef = channelRef.childByAutoId()
        let roomName = self.InputRoomName.text
        let roomItem = ["RoomName":roomName!, "RoomNum": randomRoomNum] as [String : Any]
        newRoomRef.setValue(roomItem)
        
        print("room ref is: " + String(describing: newRoomRef))
        print("room name is: " + roomName!)
        print("room num is: " + String(describing: randomRoomNum))
    }

    @IBAction func EnterRoom(_ sender: Any) {
        roomRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.value is NSNull{
                print("這是不存在的房間")
            }else{
                for child in snapshot.children{
                    let existRoom = (child as AnyObject).key as String
                    print("現有房間 " + existRoom)
                }
                //let wantedRoomSender = self.rooms 我把sender弄成self就可以了，原本是 wantedRoomSender               
                self.performSegue(withIdentifier: "ShowRoom", sender: self)
                print("輸入了想進的房號是 " + self.InputRoomNum.text!)
            }
        })
    }
    
    // MARK: Firebase related methods
    private func observeRooms() {
//        // We can use the observe method to listen for new channels being written to the Firebase DB
//        
//        roomRefHandle = roomRef.observe(.childAdded, with: { (snapshot) -> Void in
//            let roomData = snapshot.value as! Dictionary<String, AnyObject>
//            let id = snapshot.key
//            //let roomName = snapshot.key
//            //let roomNum = snapshot.key
//            if let num = roomData["RoomNum"] as! Decimal!, num< 10000 {
//                print(id)
//                //self.rooms.append(Room(id: id, roomName: "new", roomNum: "new1"))
//                //self.tableView.reloadData()
//            } else {
//                print("Error! Could not get room data from firebase")
//            }
//        })
    }
        
    // MARK: Navigation
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        //super.prepare(for: segue, sender: sender)
        //if let wantedRoomSender = sender as? Room{
            let chatVc = segue.destination as! ChatViewController
            let targetNum = self.InputRoomNum.text! as String
            chatVc.senderDisplayName = senderDisplayName
            //chatVc.targetRoomRef = roomRef.child(self.InputRoomNum.text!)
            //chatVc.room = wantedRoomSender
            chatVc.targetRoomNum = targetNum
        //}
        //else{print("error!!!!!!!!!!!")}
    }    
}
