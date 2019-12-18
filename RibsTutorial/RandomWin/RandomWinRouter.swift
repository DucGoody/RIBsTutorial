//
//  RandomWinRouter.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/18/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs

protocol RandomWinInteractable: Interactable {
    var router: RandomWinRouting? { get set }
    var listener: RandomWinListener? { get set }
}

protocol RandomWinViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RandomWinRouter: ViewableRouter<RandomWinInteractable, RandomWinViewControllable>, RandomWinRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: RandomWinInteractable, viewController: RandomWinViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
