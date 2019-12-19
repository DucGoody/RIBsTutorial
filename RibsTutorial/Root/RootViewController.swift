//
//  RootViewController.swift
//  RibsTutorial
//
//  Created by DUCHV3 on 12/16/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
import RxSwift
import SnapKit
import UIKit

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable, LoggedInViewControllable {

    weak var listener: RootPresentableListener?
    private var targetViewController: ViewControllable?
    private var animationInProgress = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    }

    // MARK: - RootViewControllable

//    func present(viewController: ViewControllable) {
//        viewController.uiviewController.modalPresentationStyle = .overCurrentContext
//        present(viewController.uiviewController, animated: true, completion: nil)
//    }
//
//    func dismiss(viewController: ViewControllable) {
//        if presentedViewController === viewController.uiviewController {
//            dismiss(animated: true, completion: nil)
//        }
//    }
    
    func replaceModal(viewController: ViewControllable?) {
        targetViewController = viewController

        guard !animationInProgress else {
            return
        }
        
        if presentedViewController != nil {
            animationInProgress = true
            dismiss(animated: true) { [unowned self] in
                if self.targetViewController != nil {
                    self.presentTargetViewController()
                } else {
                    self.animationInProgress = false
                }
            }
        } else {
            presentTargetViewController()
        }
    }
    
//    func replaceModal(viewController: ViewControllable?) {
//          targetViewController = viewController
//
//          guard !animationInProgress else {
//              return
//          }
//
//          if presentedViewController != nil {
//              animationInProgress = true
//              dismiss(animated: true) { [weak self] in
//                  if self?.targetViewController != nil {
//                      self?.presentTargetViewController()
//                  } else {
//                      self?.animationInProgress = false
//                  }
//              }
//          } else {
//              presentTargetViewController()
//          }
//      }
//
     private func presentTargetViewController() {
           if let targetViewController = targetViewController {
               animationInProgress = true
            targetViewController.uiviewController.modalPresentationStyle = .overCurrentContext
               present(targetViewController.uiviewController, animated: true) { [unowned self] in
                   self.animationInProgress = false
               }
           }
       }
}
