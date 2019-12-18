//
//  OffGameRouter.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/17/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs

protocol OffGameInteractable: Interactable, ScoreBoardListener {
    var router: OffGameRouting? { get set }
    var listener: OffGameListener? { get set }
}

protocol OffGameViewControllable: ViewControllable {
    func show(scoreView: ViewControllable)
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class OffGameRouter: ViewableRouter<OffGameInteractable, OffGameViewControllable>, OffGameRouting {
    private var scoreBoardBuilder: ScoreBoardBuildable
    // TODO: Constructor inject child builder protocols to allow building children.
//    override init(interactor: OffGameInteractable, viewController: OffGameViewControllable) {
//        super.init(interactor: interactor, viewController: viewController)
//        interactor.router = self
//    }
    
    init(interactor: OffGameInteractable,
         viewController: OffGameViewControllable,
         scoreBoardBuilder: ScoreBoardBuildable) {
        self.scoreBoardBuilder = scoreBoardBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()

        attachScoreBoard()
    }
    
    private func attachScoreBoard() {
        let scoreBoard = scoreBoardBuilder.build(withListener: interactor)
        attachChild(scoreBoard)
        viewController.show(scoreView: scoreBoard.viewControllable)
    }
}
