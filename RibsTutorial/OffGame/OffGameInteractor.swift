//
//  OffGameInteractor.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/17/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
import RxSwift

protocol OffGameRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OffGamePresentable: Presentable {
    var listener: OffGamePresentableListener? { get set }
//    func set(score: Score)
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol OffGameListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func startGame(with gameBuilder: GameBuildable)
}

final class OffGameInteractor: PresentableInteractor<OffGamePresentable>, OffGameInteractable, OffGamePresentableListener {
//    func startGame() {
//        listener?.startTicTacToe()
//    }
//
//    private let scoreStream: ScoreStream
    weak var router: OffGameRouting?
    weak var listener: OffGameListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
//    override init(presenter: OffGamePresentable) {
//        super.init(presenter: presenter)
//        presenter.listener = self
//    }
    
    override init(presenter: OffGamePresentable) {
//        self.scoreStream = scoreStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func start(_ game: Game) {
        listener?.startGame(with: game.builder)
    }
}
