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
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.contentView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20)
        ])
    }

    func addPhotoView() {
        self.contentView.addSubview(photoView)

        NSLayoutConstraint.activate([
            photoView.heightAnchor.constraint(equalToConstant: 150.0),
            photoView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            photoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.contentView.trailingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 20)
        ])
    }

    func addDescription() {
        self.contentView.addSubview(photoDescriptionLabel)

        NSLayoutConstraint.activate([
            photoDescriptionLabel.topAnchor.constraint(equalTo:self.photoView.bottomAnchor, constant: 20),
            photoDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.contentView.trailingAnchor.constraint(equalTo: photoDescriptionLabel.trailingAnchor, constant: 20)
        ])
        self.contentView.bottomAnchor.constraint(equalTo: self.photoDescriptionLabel.bottomAnchor, constant: 20).priority = UILayoutPriority(rawValue: 750)
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
