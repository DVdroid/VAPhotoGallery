//
//  VAPhotoGalleryCellView.swift
//  VAManagerBuddy
//
//  Created by Vikash Anand on 09/03/20.
//  Copyright © 2020 Vikash Anand. All rights reserved.
//

import UIKit

final class VAPhotoGalleryCellView: UIView {

    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let photoView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let photoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Book", size: 18)
        label.textColor = UIColor.lightGray
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.translatesAutoresizingMaskIntoConstraints = false
        initSubViews()
    }

    private func initSubViews() {
        self.addContentView()
        self.addTitleLabel()
        self.addPhotoView()
        self.addDescription()
    }

    private func addContentView() {
        self.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


    func addTitleLabel() {
        self.contentView.addSubview(titleLabel)
        let marginGuide = contentView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:marginGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 20)
        ])
    }

    func addPhotoView() {
        self.contentView.addSubview(photoView)
        let marginGuide = contentView.layoutMarginsGuide


        NSLayoutConstraint.activate([
            photoView.heightAnchor.constraint(equalToConstant: 150.0),
            photoView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            photoView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 20),
            photoView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 20)
        ])
    }

    func addDescription() {
        self.contentView.addSubview(photoDescriptionLabel)
        let marginGuide = contentView.layoutMarginsGuide


        NSLayoutConstraint.activate([
            photoDescriptionLabel.topAnchor.constraint(equalTo:self.photoView.bottomAnchor, constant: 20),
            photoDescriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 20),
            photoDescriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 20),
            self.photoDescriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: marginGuide.bottomAnchor, constant: 0)
            
        ])
       // self.contentView.bottomAnchor.constraint(greaterThanOrEqualTo: self.photoDescriptionLabel.bottomAnchor, constant: 20).priority = UILayoutPriority(rawValue: 750)
    }
}

extension VAPhotoGalleryCellView: CellChildViewConfigurable {
    
    func resetCell() {
        self.titleLabel.text = nil
        self.photoDescriptionLabel.text = nil
        self.photoView.cancelImageLoad()
        self.photoView.image = UIImage(named: "default-profile-icon")!
    }
    
    func configure(with photo: VAPhoto) {
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
}
