//
//  hashTagViewController.swift
//  Swift6-Kcommunity
//
//  Created by Sena Nishida on 2021/02/26.
//

import UIKit
import SDWebImage

class hashTagViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LoadOKDelegate {
    
    var hashTag = String()
    var loadDBModel = LoadModel()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        loadDBModel.loadOKDelegate = self
        
        self.navigationItem.title = "#\(hashTag)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topImageView.layer.cornerRadius = 60
        loadDBModel.loadHashTag(hashTag: hashTag)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countLabel.text = String(loadDBModel.datasets.count)
        return loadDBModel.datasets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let contentView = cell.contentView.viewWithTag(1) as! UIImageView
        
        contentView.sd_setImage(with: URL(string: loadDBModel.datasets[indexPath.row].image), completed: nil)
        topImageView.sd_setImage(with: URL(string: loadDBModel.datasets[0].image), completed: nil)
        
        return cell
    }
    
    func loadOK(check: Int) {
        if check == 1{
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(identifier: "detailVC") as! DetailViewController
        detailVC.userName = loadDBModel.datasets[indexPath.row].userName
        detailVC.userImage = loadDBModel.datasets[indexPath.row].userImageString
        detailVC.eventName = loadDBModel.datasets[indexPath.row].eventName
        detailVC.eventDate = loadDBModel.datasets[indexPath.row].eventDate
        detailVC.eventDetail = loadDBModel.datasets[indexPath.row].detailString
        detailVC.eventImage = loadDBModel.datasets[indexPath.row].image
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/3.0
        let height = width
        
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
