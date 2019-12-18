//
//  ScoreBoardBuilder.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/18/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs

protocol ScoreBoardDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var player1Name: String { get }
    var player2Name: String { get }
    var scoreStream: ScoreStream { get }
}

final class ScoreBoardComponent: Component<ScoreBoardDependency> {
    fileprivate var player1Name: String {
        return dependency.player1Name
    }

    fileprivate var player2Name: String {
        return dependency.player2Name
    }

    fileprivate var scoreStream: ScoreStream {
        return dependency.scoreStream
    }
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ScoreBoardBuildable: Buildable {
    func build(withListener listener: ScoreBoardListener) -> ScoreBoardRouting
}

final class ScoreBoardBuilder: Builder<ScoreBoardDependency>, ScoreBoardBuildable {

    override init(dependency: ScoreBoardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ScoreBoardListener) -> ScoreBoardRouting {
        let component = ScoreBoardComponent(dependency: dependency)
        let viewController = ScoreBoardViewController(player1Name: component.player1Name,
                                                           player2Name: component.player2Name)
        let interactor = ScoreBoardInteractor(presenter: viewController,
                                                   scoreStream: component.scoreStream)
        interactor.listener = listener
        return ScoreBoardRouter(interactor: interactor, viewController: viewController)
    }
}
