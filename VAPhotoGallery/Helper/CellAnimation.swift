//
//  CellAnimation.swift
//  VAPhotoGallery
//
//  Created by Anuj Rai on 28/04/20.
//  Copyright © 2020 Vikash Anand. All rights reserved.
//

import UIKit


typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

enum AnimationFactory {

    static func makeFade(duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, _ in
            cell.alpha = 0

            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
        }
    }

    static func makeMoveUpWithBounce(rowHeight: CGFloat,
                                     duration: TimeInterval,
                                     delayFactor: Double,
                                     reverseAnimation: Bool) -> Animation {

        if !reverseAnimation {

            return { cell, indexPath, tableView in
                cell.transform = CGAffineTransform(translationX: 0, y: rowHeight)

                UIView.animate(
                    withDuration: duration,
                    delay: delayFactor * Double(indexPath.row),
                    usingSpringWithDamping: 1,
                    initialSpringVelocity: 0.5,
                    options: [.curveEaseInOut],
                    animations: {
                        cell.transform = CGAffineTransform(translationX: 0, y: 0)
                })
            }

        } else {

            return { cell, indexPath, tableView in
                cell.transform = CGAffineTransform(translationX: 0, y: 0)

                UIView.animate(
                    withDuration: duration,
                    delay: delayFactor * Double(indexPath.row),
                    usingSpringWithDamping: 1,
                    initialSpringVelocity: 0.5,
                    options: [.curveEaseInOut],
                    animations: {
                        cell.transform = CGAffineTransform(translationX: 0, y: rowHeight)
                })
            }

        }
    }

    static func zoom () -> Animation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: 0.5, y: 0.7)
            cell.transform = CGAffineTransform(scaleX: 0, y : 0)
            UIView.animate(withDuration: 0.5, animations: {
                cell.transform = CGAffineTransform(scaleX: 1, y : 1)
            })
            
        }
        
    }

    static func makeSlideIn(duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)

            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }

    static func makeMoveUpWithFade(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight / 2)
            cell.alpha = 0

            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.alpha = 1
            })
        }
    }
}

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }

        return lastIndexPath == indexPath
    }
}


final class CellAnimator {
    private var hasAnimatedAllCells = false
    private let animation: Animation

    init(animation: @escaping Animation) {
        self.animation = animation
    }

    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else {
            return
        }

        animation(cell, indexPath, tableView)
        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
}
