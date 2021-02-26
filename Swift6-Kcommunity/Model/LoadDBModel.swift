//
//  LoadDBModel.swift
//  Swift6-Kcommunity
//
//  Created by Sena Nishida on 2021/02/26.
//

import Foundation
import Firebase

class LoadModel {
    var datasets = [Dataset]()
    let db = Firestore.firestore()
    
    func loadContents(){
        db.collection("events").order(by: "postDate").addSnapshotListener { (snapShot, error) in
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
                    }
                }
            }
        }
    }
}
