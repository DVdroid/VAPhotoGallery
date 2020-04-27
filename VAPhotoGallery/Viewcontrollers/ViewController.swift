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
        static let tableAutomaticRowHeight = 220.0
        static let screenTitle = "Employees"
        static let cellIdentifier = "PhotoGallery"
           
       }
    @IBOutlet var photoTableView: UITableView! {
           didSet {
            self.photoTableView.dataSource = self
            self.photoTableView.register(VAPhotoGalleryCell.self, forCellReuseIdentifier: "photoCell")
            self.photoTableView.estimatedRowHeight = CGFloat(Constants.tableAutomaticRowHeight)
            self.photoTableView.rowHeight = UITableView.automaticDimension
           }
       }

    var photoModelArray = [VAPhoto]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoTableView.rowHeight = CGFloat(Constants.tableAutomaticRowHeight)
        self.createProductArray()
        
    }
    
    func createProductArray() {
        let photo1 = VAPhoto(title: "Glasses", imageUrl: "img1", description: "This is best Glasses I've ever seen")
         let photo2 = VAPhoto(title: "Desert", imageUrl: "img2", description: "This is so yummy")
         let photo3 = VAPhoto(title: "Camera Lens", imageUrl: "img3", description: "I wish I had this camera lens")
        self.photoModelArray.append(photo1)
        self.photoModelArray.append(photo2)
        self.photoModelArray.append(photo3)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! VAPhotoGalleryCell
        let currentLastItem = photoModelArray[indexPath.row]
        cell.titleLabel.text = currentLastItem.title
        cell.photo.image = UIImage(named: currentLastItem.imageUrl ?? "", in: Bundle.main, compatibleWith: nil)
        cell.photoDescriptionLabel.text = currentLastItem.description

        return cell
    }
}

