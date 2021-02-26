//
//  DetailViewController.swift
//  Swift6-Kcommunity
//
//  Created by Sena Nishida on 2021/02/26.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var userName = String()
    var eventName = String()
    var eventDate = String()
    var eventDetail = String()
    var userImage = String()
    var eventImage = String()
    
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImageView.layer.cornerRadius = 50.0
        
        userNameLabel.text = userName
        contentImageView.sd_setImage(with: URL(string: eventImage), completed: nil)
        userImageView.sd_setImage(with: URL(string: userImage), completed: nil)
        eventNameLabel.text = eventName
        dateLabel.text = eventDate
        detailLabel.text = eventDetail
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
