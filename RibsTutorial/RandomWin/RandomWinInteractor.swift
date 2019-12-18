//
//  RandomWinInteractor.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/18/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
import RxSwift

protocol RandomWinRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RandomWinPresentable: Presentable {
    var listener: RandomWinPresentableListener? { get set }
    func announce(winner: PlayerType, withCompletionHandler handler: @escaping () -> ())
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RandomWinListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didRandomlyWin(with player: PlayerType)
}

final class RandomWinInteractor: PresentableInteractor<RandomWinPresentable>, RandomWinInteractable, RandomWinPresentableListener {

    weak var router: RandomWinRouting?
    weak var listener: RandomWinListener?
    private let mutableScoreStream: MutableScoreStream

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: RandomWinPresentable,
         mutableScoreStream: MutableScoreStream) {
        self.mutableScoreStream = mutableScoreStream
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
    
    func determineWinner() {
        let random = arc4random_uniform(100)
        let winner = random > 50 ? PlayerType.player1 : PlayerType.player2
        presenter.announce(winner: winner) {
            self.mutableScoreStream.updateScore(withWinner: winner)
            self.listener?.didRandomlyWin(with: winner)
        }
    }
}
