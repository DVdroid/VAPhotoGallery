//
//  UIAlertController+Helper.swift
//  VAManagerBuddy
//
//  Created by Vikash Anand on 15/03/20.
//  Copyright © 2020 Vikash Anand. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    class func showSwitchToOnlineMode(inParent parentController: UIViewController,
                                      withHandler handler: @escaping (UIAlertAction)->Void) {
        
        let title = "Application is Online"
        let message = "Do you want to switch back to online mode?"
        let switchBackToOnlineModeAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        UIAlertController.showAlert(inParent: parentController,
                                    preferredStyle: .alert,
                                    withTitle: title,
                                    alertMessage: message,
                                    andAlertActions: [switchBackToOnlineModeAction, cancelAction])
    }
    
    class func showNoRecordsPrompt(inParent parentController: UIViewController) {
        let title = "No Records"
        let message = "No record / records found."
        let switchBackToOnlineModeAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        UIAlertController.showAlert(inParent: parentController,
                                    preferredStyle: .alert,
                                    withTitle: title,
                                    alertMessage: message,
                                    andAlertActions: [switchBackToOnlineModeAction])
    }
    
    class func showConfirmDelete(forName name: String,
                                 inParent parentController: UIViewController,
                                 alertActionCallback callBack: @escaping (UIAlertAction)->Void) {
        
        let title = "Delete Employee"
        let message = "Are you sure you want to permanently delete \(name)?"
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { alertAction in
            callBack(alertAction)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { alertAction in
            callBack(alertAction)
        })
        
        UIAlertController.showAlert(inParent: parentController,
                                    preferredStyle: .actionSheet,
                                    withTitle: title,
                                    alertMessage: message,
                                    andAlertActions: [deleteAction, cancelAction])
    }
    
    class func showSortOption(inParent parentController: UIViewController,
                              alertActionCallback callBack: @escaping (UIAlertAction)->Void) {
        
        let title = "Sort By:"
        let message = "Pick a sorting criteria"
        
        let sortByLastNameAction = UIAlertAction(title: "Last Name", style: .default, handler: { alertAction in
            callBack(alertAction)
        })
        let sortByAgeAction = UIAlertAction(title: "Age", style: .default, handler: { alertAction in
            callBack(alertAction)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        UIAlertController.showAlert(inParent: parentController,
                                    preferredStyle: .actionSheet,
                                    withTitle: title,
                                    alertMessage: message,
                                    andAlertActions: [sortByLastNameAction, sortByAgeAction, cancelAction])
    }
    
    private class func showAlert(inParent parent: UIViewController,
                                 preferredStyle style: Style,
                                 withTitle title: String,
                                 alertMessage message: String,
                                 andAlertActions actions: [UIAlertAction]?) {
        
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: style)
        
        if let alertActions = actions {
            _ = alertActions.map{ alertVC.addAction($0) }
        }
        
        parent.popoverPresentationController?.sourceView = parent.view
        parent.popoverPresentationController?.sourceRect = CGRect(x: parent.view.bounds.width / 2.0,
                                                                  y: parent.view.bounds.height / 2.0,
                                                                  width: 1.0,
                                                                  height: 1.0)
        
        parent.present(alertVC, animated: true, completion: nil)
    }
}
