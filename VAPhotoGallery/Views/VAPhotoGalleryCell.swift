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

        self.contentView.addSubview(self.childView)
        NSLayoutConstraint.activate([
            childView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            childView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: childView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: childView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        childView.resetCell()
    }

}
