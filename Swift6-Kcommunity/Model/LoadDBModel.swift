//
//  LoadDBModel.swift
//  Swift6-Kcommunity
//
//  Created by Sena Nishida on 2021/02/26.
//

import Foundation
import Firebase

protocol LoadOKDelegate {
    func loadOK(check:Int)
}

class LoadModel {
    var datasets = [Dataset]()
    let db = Firestore.firestore()
    
    var loadOKDelegate:LoadOKDelegate?
    
    func loadContents(){
        db.collection("events").order(by: "postDate").addSnapshotListener { (snapShot, error) in
            self.datasets = []
            if error != nil {
                print(error.debugDescription)
                return
            }
            if let snapShotDoc = snapShot?.documents {
                for doc in snapShotDoc {
                    let data = doc.data()
                    if let userID = data["userID"] as? String,
                       let userName = data["userName"] as? String,
                       let userImageString = data["userImageString"] as? String,
                       let eventName = data["eventName"] as? String,
                       let eventDate = data["eventDate"] as? String,
                       let detailString = data["detailString"] as? String,
                       let image = data["image"] as? String,
                       let postDate = data["postDate"] as? Double {
                        let newDataset = Dataset(userID: userID, userName: userName, userImageString: userImageString, eventName: eventName, eventDate: eventDate, detailString: detailString, image: image, postDate: postDate)
                        self.datasets.append(newDataset)
                        self.datasets.reverse()
                        self.loadOKDelegate?.loadOK(check: 1)
                    }
                }
            }
        }
    }
    func loadHashTag(hashTag:String){
        //addSnapShotListnerは値が更新される度に自動で呼ばれる
        db.collection("#\(hashTag)").order(by:"postDate").addSnapshotListener { (snapShot, error) in
            
            self.datasets = []
            
            if error != nil{
                print(error.debugDescription)
                return
            }
            if let snapShotDoc = snapShot?.documents {
                for doc in snapShotDoc {
                    let data = doc.data()
                    if let userID = data["userID"] as? String,
                       let userName = data["userName"] as? String,
                       let userImageString = data["userImageString"] as? String,
                       let eventName = data["eventName"] as? String,
                       let eventDate = data["eventDate"] as? String,
                       let detailString = data["detailString"] as? String,
                       let image = data["image"] as? String,
                       let postDate = data["postDate"] as? Double {
                        let newDataset = Dataset(userID: userID, userName: userName, userImageString: userImageString, eventName: eventName, eventDate: eventDate, detailString: detailString, image: image, postDate: postDate)
                        self.datasets.append(newDataset)
                        self.datasets.reverse()
                        self.loadOKDelegate?.loadOK(check: 1)
                    }
                }
            }
        }
    }
}
