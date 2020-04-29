//
//  VAPhotoGalleryCell.swift
//  VAPhotoGallery
//
//  Created by Anuj Rai on 27/04/20.
//  Copyright © 2020 Vikash Anand. All rights reserved.
//

import UIKit
import Foundation

protocol CellChildViewConfigurable where Self : UIView {
    func configure(with photo: VAPhoto)
    func resetCell()
}

protocol CellConfigurable where Self : UITableViewCell {
    var childView: CellChildViewConfigurable { get }
    func addChildViewAsSubview()
}

class VAPhotoGalleryCell: UITableViewCell, CellConfigurable, ReusableView {
    
    lazy var childView: CellChildViewConfigurable = VAPhotoGalleryCellView()
    
    let photoView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 5
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let photoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Book", size: 16)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addChildViewAsSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented!!!")
    }
    
    func addChildViewAsSubview() {
        
        self.addTitleLabel()
        self.addPhotoView()
        self.addDescription()
        
    }
    
    func addTitleLabel() {
        self.contentView.addSubview(titleLabel)
        let marginGuide = contentView.layoutMarginsGuide
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
    }
    
    func addPhotoView() {
        self.contentView.addSubview(photoView)
        let marginGuide = contentView.layoutMarginsGuide
        
        self.contentView.addSubview(photoDescriptionLabel)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        photoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        photoView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        photoView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
    }
    
    func addDescription() {
        
        let marginGuide = contentView.layoutMarginsGuide
        self.contentView.addSubview(photoDescriptionLabel)
        
        photoDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        photoDescriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        photoDescriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -20).isActive = true
        photoDescriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        photoDescriptionLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 20).isActive = true
        
    }
    
    func configures(with photo: VAPhoto) {
        self.titleLabel.text = photo.title
        self.photoDescriptionLabel.text = photo.description
        self.updateThumbnail(with: photo)
    }
    private func updateThumbnail(with photo: VAPhoto) {
        if let urlString = photo.imageUrl,
            let url = URL(string: urlString) {
            self.photoView.loadImage(at: url)
        }
        
    }
    override func prepareForReuse() {
        childView.resetCell()
    }
}
