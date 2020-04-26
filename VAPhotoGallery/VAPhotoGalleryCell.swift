//
//  VAPhotoGalleryCell.swift
//  VAPhotoGallery
//
//  Created by Anuj Rai on 27/04/20.
//  Copyright © 2020 Vikash Anand. All rights reserved.
//

import UIKit
import Foundation

class VAPhotoGalleryCell: UITableViewCell {
    
    let photo: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let photoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.yellow
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
       // label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //     var description: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addTitleLabel()
        self.addPhoto()
        self.addDescription()
        
        

    }
    func addTitleLabel() {
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 20)
        ])
    }
    func addPhoto() {
        self.addSubview(photo)

        NSLayoutConstraint.activate([
            photo.heightAnchor.constraint(equalToConstant: 150.0),
            photo.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            photo.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 20)
        ])
    }
    func addDescription() {
        self.addSubview(photoDescriptionLabel)

        NSLayoutConstraint.activate([
            photoDescriptionLabel.topAnchor.constraint(equalTo:self.photo.bottomAnchor, constant: 20),
            photoDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            photoDescriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 20),
            self.contentView.bottomAnchor.constraint(equalTo: self.photoDescriptionLabel.bottomAnchor, constant: 20)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
