//
//  SendDBModel.swift
//  Swift6-Kcommunity
//
//  Created by Sena Nishida on 2021/02/26.
//

import Foundation
import FirebaseStorage

protocol SendProfileOKDelegate {
    func sendProfileOKDelegate(url:String)
}

class SendDBModel {
    
    var sendProfileOKDelegate:SendProfileOKDelegate?
    
    init() {
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
