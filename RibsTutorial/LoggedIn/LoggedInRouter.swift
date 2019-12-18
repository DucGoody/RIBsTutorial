//
//  LoggedInRouter.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/17/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener, GameListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
//    func present(viewController: ViewControllable)
//    func dismiss(viewController: ViewControllable)
    func replaceModal(viewController: ViewControllable?)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {

//    init(interactor: LoggedInInteractable,
//         viewController: LoggedInViewControllable,
//         offGameBuilder: OffGameBuildable,
//         ticTacToeBuilder: TicTacToeBuildable) {
//        self.viewController = viewController
//        self.offGameBuilder = offGameBuilder
//        self.ticTacToeBuilder = ticTacToeBuilder
//        super.init(interactor: interactor)
//        interactor.router = self
//    }
    
    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         offGameBuilder: OffGameBuildable) {
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }
//
//    override func didLoad() {
//        super.didLoad()
//        attachOffGame()
//    }

    // MARK: - LoggedInRouting

    func cleanupViews() {
        if currentChild != nil {
            viewController.replaceModal(viewController: nil)
        }
    }

//    func routeToTicTacToe() {
//        detachCurrentChild()
//
//        let ticTacToe = ticTacToeBuilder.build(withListener: interactor)
//        currentChild = ticTacToe
//        attachChild(ticTacToe)
//        viewController.present(viewController: ticTacToe.viewControllable)
//    }
//
    func routeToOffGame(with games: [Game]) {
        detachCurrentChild()
        attachOffGame(with: games)
    }
    
    func routeToGame(with gameBuilder: GameBuildable) {
        detachCurrentChild()
        let game = gameBuilder.build(withListener: interactor)
        self.currentChild = game
        attachChild(game)
        viewController.replaceModal(viewController: game.viewControllable)
    }

//    func routeToOffGame() {
//        detachCurrentChild()
//        attachOffGame(with: <#[Game]#>)
//    }

    // MARK: - Private

    private let viewController: LoggedInViewControllable
    private let offGameBuilder: OffGameBuildable
//    private let ticTacToeBuilder: TicTacToeBuildable
    private var currentChild: ViewableRouting?

//    private func attachOffGame() {
//        let offGame = offGameBuilder.build(withListener: interactor)
//        self.currentChild = offGame
//        attachChild(offGame)
//        viewController.present(viewController: offGame.viewControllable)
//    }
    
    private func attachOffGame(with games: [Game]) {
        let offGame = offGameBuilder.build(withListener: interactor, games: games)
        self.currentChild = offGame
        attachChild(offGame)
        viewController.replaceModal(viewController: offGame.viewControllable)
    }

    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.replaceModal(viewController: nil)
        }
    }
}
