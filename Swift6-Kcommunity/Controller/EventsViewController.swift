//
//  EventsViewController.swift
//  Swift6-Kcommunity
//
//  Created by Sena Nishida on 2021/02/26.
//

import UIKit
import Firebase
import ActiveLabel
import SDWebImage

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    var loadDBModel = LoadModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        //firebaseのデータを取り出す
        loadDBModel.loadContents()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadDBModel.datasets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let image = cell.contentView.viewWithTag(1) as! UIImageView
        image.sd_setImage(with: URL(string: loadDBModel.datasets[indexPath.row].image), completed: nil)
        let eventName = cell.contentView.viewWithTag(2) as! UILabel
        eventName.text = loadDBModel.datasets[indexPath.row].eventName
        let detailText = cell.contentView.viewWithTag(3) as! ActiveLabel
        detailText.enabledTypes = [.hashtag]
        detailText.text = "\(loadDBModel.datasets[indexPath.row].detailString)"
        detailText.handleHashtagTap { (hashTag) in
            print(hashTag)
            
            let hashVC = self.storyboard?.instantiateViewController(identifier: "hashVC") as! hashTagViewController
            hashVC.hashTag = hashTag
            self.navigationController?.pushViewController(hashVC, animated: true)
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
