//
//  ViewController.swift
//  VAPhotoGallery
//
//  Created by Vikash Anand on 26/04/20.
//  Copyright © 2020 Vikash Anand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Constants Enum
       private enum Constants {
        static let tableAutomaticRowHeight = 10.0
        static let screenTitle = "Employees"
        static let cellIdentifier = "PhotoGallery"
           
       }
    @IBOutlet var photoTableView: UITableView! {
           didSet {
            self.photoTableView.dataSource = self
            self.photoTableView.register(VAPhotoGalleryCell.self, forCellReuseIdentifier: "photoCell")
            self.photoTableView.estimatedRowHeight = UITableView.automaticDimension
           }
       }

    var photoModelArray = [VAPhotoModel]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoTableView.rowHeight = CGFloat(Constants.tableAutomaticRowHeight)
        self.createProductArray()
        
    }
    
    func createProductArray() {
        self.photoModelArray.append(VAPhotoModel(photoTilte: "Glasses", photoImageUrl: "img1" , photoDescription: "This is best Glasses I've ever seen"))
        self.photoModelArray.append(VAPhotoModel(photoTilte: "Desert", photoImageUrl: "img2" , photoDescription: "This is so yummy"))
        self.photoModelArray.append(VAPhotoModel(photoTilte: "Camera Lens", photoImageUrl:  "img3", photoDescription: "I wish I had this camera lens"))
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! VAPhotoGalleryCell
        let currentLastItem = photoModelArray[indexPath.row]
        cell.titleLabel.text = currentLastItem.photoTilte
        cell.photo.image = UIImage(named: currentLastItem.photoImageUrl ?? "", in: Bundle.main, compatibleWith: nil)
        cell.photoDescriptionLabel.text = currentLastItem.photoDescription

        return cell
    }
}

