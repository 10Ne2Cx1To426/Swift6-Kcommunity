//
//  EditViewController.swift
//  Swift6-Kcommunity
//
//  Created by Sena Nishida on 2021/02/26.
//

import UIKit
import FirebaseAuth
import Firebase

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextView!
    
    var roomNumber = Int()
    
    var urlString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventTextField.delegate = self
        dateTextField.delegate = self
        detailTextField.delegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        eventTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        detailTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        eventTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        detailTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func tapImageView(_ sender: Any) {
        showAlert()
    }
    //送信
    @IBAction func send(_ sender: Any) {
        if eventTextField.text?.isEmpty != true && dateTextField.text?.isEmpty != true &&
            detailTextField.text.isEmpty != true, let image = imageView.image{
            let passImage = image.jpegData(compressionQuality: 0.01)
            let sendDBModel = SendDBModel(userID: Auth.auth().currentUser!.uid, userName: UserDefaults.standard.object(forKey: "userName") as! String, userImageString: UserDefaults.standard.object(forKey: "userImage") as! String, eventName: eventTextField.text!, eventDate: dateTextField.text!, detailString: detailTextField.text!, image: passImage!)
            sendDBModel.sendData()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func doCamera() {
        let sourceType:UIImagePickerController.SourceType = .camera
        //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    func doAlbum() {
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        //アルバム利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] as? UIImage != nil {
            let selectedImage = info[.originalImage] as! UIImage
            imageView.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    //アラート
    func showAlert() {
        let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか?", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            self.doCamera()
        }
        let action2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            self.doAlbum()
        }
        let action3 = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
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
