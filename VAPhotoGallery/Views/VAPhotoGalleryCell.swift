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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addChildViewAsSubview()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented!!!")
    }

    func addChildViewAsSubview() {
        contentView.addSubview(childView)
        NSLayoutConstraint.activate([
            childView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            childView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.trailingAnchor.constraint(equalTo: childView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: childView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func prepareForReuse() {
        childView.resetCell()
    }
}
