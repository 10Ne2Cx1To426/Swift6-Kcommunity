//
//  ChatViewController.swift
//  Swift6-Kcommunity
//
//  Created by Sena Nishida on 2021/02/26.
//

import UIKit
import Firebase
import SDWebImage

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var roomName = String()
    var profileImageString = String()
    
    var messages:[Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            profileImageString = UserDefaults.standard.object(forKey: "userImage") as! String
        }
        self.navigationItem.title = roomName
        loadMessages(roomName: roomName)
    }
    //firestoreに保存されている値を取ってくる
    func loadMessages(roomName:String) {
        db.collection(roomName).order(by: "postDate").addSnapshotListener { (snapShot, error) in
            self.messages = []
            if error != nil {
                print(error.debugDescription)
                return
            }
            if let snapShotDoc = snapShot?.documents {
                for doc in snapShotDoc {
                    let data = doc.data()
                    if let sender = data["sender"] as? String, let body = data["body"] as? String, let imageString = data["imageString"] as? String {
                        let newMessage = Message(sender: sender, body: body, imageString: imageString)
                        self.messages.append(newMessage)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            //送信したら画面が一番したまで自動的に表示させるようにする
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                    }
                }
            }
        }
    }
    @IBAction func send(_ sender: Any) {
        if let messageBody = messageTextField.text, let sender = Auth.auth().currentUser?.email {
            db.collection(roomName).addDocument(data: ["sender":sender, "body":messageBody, "imageString":profileImageString, "postDate":Date().timeIntervalSince1970]) { (error) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                DispatchQueue.main.async {
                self.messageTextField.text = ""
                self.messageTextField.resignFirstResponder()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MessageCell
        let message = messages[indexPath.row]
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.rightImageView.sd_setImage(with: URL(string: profileImageString), completed: nil)
            cell.leftImageView.sd_setImage(with: URL(string: messages[indexPath.row].imageString), completed: nil)
            
            cell.backView.backgroundColor = .systemTeal
            cell.label.textColor = .white
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.rightImageView.sd_setImage(with: URL(string: profileImageString), completed: nil)
            cell.leftImageView.sd_setImage(with: URL(string: messages[indexPath.row].imageString), completed: nil)
            
            cell.backView.backgroundColor = .orange
            cell.label.textColor = .white
        }
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
