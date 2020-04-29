//
//  RootViewController.swift
//  VAPhotoGallery
//
//  Created by Vikash Anand on 26/04/20.
//  Copyright © 2020 Vikash Anand. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {

    private enum Constants {
        static let photoUrlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        static let refreshButtonTitle = "Refresh"
    }

    private enum State {
        case pending
        case loading(spinner: SpinnerView )
        case loaded(inView: PhotoTableView, withRefreshButton: UIBarButtonItem)
        case failed(error: Error?, retryView: NoConnectionView?)
    }

    var lastVelocityYSign = 0

    var visibleView: AddableRemovable? {
        willSet { visibleView?.removeAsSubView() }
        didSet { if let visibleView = visibleView { visibleView.addAsSubView(in: view )}}
    }

    private lazy var refreshButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: Constants.refreshButtonTitle,
                                            style: .done,
                                            target: self,
                                            action: #selector(refreshPhotoTableView))
        return barButtonItem
    }()

    @objc private func refreshPhotoTableView() {
        state = .loading(spinner: SpinnerView())
        fetchPhotos()
    }

    private var state: State = .pending {
        didSet {
            switch state {
            case .pending: visibleView = nil
            case .loading(let spinnerView): visibleView = spinnerView
            case .failed(let error, let retryView): visibleView = retryView
            if let error = error as? DataFetchingError, error == DataFetchingError.noRecords {
                UIAlertController.showNoRecordsPrompt(inParent: self)
                }
            case .loaded(let photoTableView, let refreshButton):
                self.navigationItem.rightBarButtonItem = refreshButton
                photoTableView.reloadData()
                visibleView = photoTableView
            }
        }
    }

    private lazy var tableView = PhotoTableView(frame: .zero, style: .plain)
    var photos: [VAPhoto]?

    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        ReachabilityManager.updateApplicationConnectionStatus()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self

        state = .loading(spinner: SpinnerView())
        fetchPhotos()
    }

    private func fetchPhotos() {

        guard let photoUrl = URL(string: Constants.photoUrlString) else { return }
        NetworkWrapper.sharedInstance.fetchMembers(for: photoUrl) { (result: Result<VAResponseModel, Error>) in
            switch result {
            case .success(let responseModel):
                self.title = responseModel.pictureCollectionTitle
                self.photos = responseModel.photos
                self.state = .loaded(inView: self.tableView, withRefreshButton: self.refreshButton)

            case .failure(let error):
                self.state = .failed(error: error, retryView: NoConnectionView {} )
            }
        }
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentVelocityY =  scrollView.panGestureRecognizer.velocity(in: scrollView.superview).y
        let currentVelocityYSign = Int(currentVelocityY).signum()
        if currentVelocityYSign != lastVelocityYSign &&
            currentVelocityYSign != 0 {
            lastVelocityYSign = currentVelocityYSign
        }
        if lastVelocityYSign < 0 {
            self.tableView.scrollDirection = .down
        } else if lastVelocityYSign > 0 {
            self.tableView.scrollDirection = .up
        }
    }
}


extension RootViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VAPhotoGalleryCell = tableView.dequeueReusableCell()
        guard let photo = photos?[indexPath.row] else { return cell }
        cell.childView.configure(with: photo)

        return cell
    }
}

extension RootViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let photoTableView = tableView as? PhotoTableView else { return }
        let flipAnimation = photoTableView.scrollDirection == .down ? false : true
        let animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height,
                                                                    duration: 0.5,
                                                                    delayFactor: 0.05,
                                                                    flipAnimation: flipAnimation)
        let animator = CellAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}





