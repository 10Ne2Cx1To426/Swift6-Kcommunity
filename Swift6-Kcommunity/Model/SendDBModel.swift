//
//  SendDBModel.swift
//  Swift6-Kcommunity
//
//  Created by Sena Nishida on 2021/02/26.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

protocol SendProfileOKDelegate {
    func sendProfileOKDelegate(url:String)
}

class SendDBModel {
    
    var sendProfileOKDelegate:SendProfileOKDelegate?
    
    var userID = String()
    var userName = String()
    var userImageString = String()
    var eventName = String()
    var eventDate = String()
    var detailString = String()
    var image = Data()
    
    var db = Firestore.firestore()
    
    
    init() {
    }
    init(userID:String, userName:String, userImageString:String, eventName:String, eventDate:String, detailString:String, image:Data ) {
        self.userID = userID
        self.userName = userName
        self.userImageString = userImageString
        self.eventName = eventName
        self.eventDate = eventDate
        self.detailString = detailString
        self.image = image
    }
    func sendData() {
        
        let imageRef = Storage.storage().reference().child("Images").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(image, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            imageRef.downloadURL { (url, error) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                //db送信処理
                self.db.collection("events").document().setData(
                    ["userID":self.userID as Any, "userName":self.userName as Any, "userImageString":self.userImageString as Any, "eventName":self.eventName as Any, "eventDate":self.eventDate as Any, "detailString":self.detailString as Any, "image":url?.absoluteString as Any, "postDate":Date().timeIntervalSince1970]
                )
            }
        }
    }
    
    func sendProfileImageData(data:Data) {
        let image = UIImage(data: data)
        let profileImage = image?.jpegData(compressionQuality: 0.1)
        
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(profileImage!, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            imageRef.downloadURL { (url, error) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                UserDefaults.standard.setValue(url?.absoluteString, forKey: "userImage")
                self.sendProfileOKDelegate?.sendProfileOKDelegate(url: url!.absoluteString)
            }
        }
    }
    
}
