//
//  OffGameBuilder.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/17/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs

protocol OffGameDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var player1Name: String {get}
    var player2Name: String {get}
    var scoreStream: ScoreStream { get }
}

final class OffGameComponent: Component<OffGameDependency>, ScoreBoardDependency {
    var player1Name: String {
        return dependency.player1Name
    }
    
    var player2Name: String {
        return dependency.player2Name
    }
    
    var scoreStream: ScoreStream {
        return dependency.scoreStream
    }
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol OffGameBuildable: Buildable {
    func build(withListener listener: OffGameListener, games: [Game]) -> OffGameRouting
}

final class OffGameBuilder: Builder<OffGameDependency>, OffGameBuildable {
    override init(dependency: OffGameDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: OffGameListener, games: [Game]) -> OffGameRouting {
        let component = OffGameComponent(dependency: dependency)
        let viewController = OffGameViewController(games: games)
        let interactor = OffGameInteractor(presenter: viewController)
        interactor.listener = listener

        let scoreBoardBuilder = ScoreBoardBuilder(dependency: component)
        let router = OffGameRouter(interactor: interactor,
                                   viewController: viewController,
                                   scoreBoardBuilder: scoreBoardBuilder)
        return router
    }

//    func build(withListener listener: OffGameListener) -> OffGameRouting {
//        let component = OffGameComponent(dependency: dependency)
//        let viewController = OffGameViewController.init(player1Name: component.player1Name, player2Name: component.player2Name)
//        let interactor = OffGameInteractor(presenter: viewController, scoreStream: component.scoreStream)
//        interactor.listener = listener
//        return OffGameRouter(interactor: interactor, viewController: viewController)
//    }
}
