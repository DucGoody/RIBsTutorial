//
//  RootRouter.swift
//  RibsTutorial
//
//  Created by DUCHV3 on 12/16/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func replaceModal(viewController: ViewControllable?)
//    func present(viewController: ViewControllable)
//    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let loggedOutBuilder: LoggedOutBuildable
    private let loggedInBuilder: LoggedInBuildable
    private var loggedOut: ViewableRouting?
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuildable, loggedInBuilder: LoggedInBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
//        let loggedOut = loggedOutBuilder.build(withListener: interactor)
//        self.loggedOut = loggedOut
//        attachChild(loggedOut)
//        viewController.present(viewController: loggedOut.viewControllable)
    }
    
    func routeToLoggedIn(withPlayer1Name player1Name: String, player2Name: String) -> LoggedInActionableItem{
        if let loggedOut = self.loggedOut {
            detachChild(loggedOut)
            viewController.replaceModal(viewController: nil)
            self.loggedOut = nil
        }
        
        let loggedIn = loggedInBuilder.build(withListener: interactor, player1Name: player1Name, player2Name: player2Name)
        attachChild(loggedIn.router)
        return loggedIn.actionableItem
    }
    
    private func routeToLoggedOut() {
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        viewController.replaceModal(viewController: loggedOut.viewControllable)
    }
}
