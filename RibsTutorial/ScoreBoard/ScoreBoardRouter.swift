//
//  ScoreBoardRouter.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/18/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs

protocol ScoreBoardInteractable: Interactable {
    var router: ScoreBoardRouting? { get set }
    var listener: ScoreBoardListener? { get set }
}

protocol ScoreBoardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ScoreBoardRouter: ViewableRouter<ScoreBoardInteractable, ScoreBoardViewControllable>, ScoreBoardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ScoreBoardInteractable, viewController: ScoreBoardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
