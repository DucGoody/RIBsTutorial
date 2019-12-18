//
//  ScoreBoardInteractor.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/18/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
import RxSwift

protocol ScoreBoardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ScoreBoardPresentable: Presentable {
    var listener: ScoreBoardPresentableListener? { get set }
    func set(score: Score)
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ScoreBoardListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ScoreBoardInteractor: PresentableInteractor<ScoreBoardPresentable>, ScoreBoardInteractable, ScoreBoardPresentableListener {

    weak var router: ScoreBoardRouting?
    weak var listener: ScoreBoardListener?
    private let scoreStream: ScoreStream

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: ScoreBoardPresentable, scoreStream: ScoreStream) {
        self.scoreStream = scoreStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        updateScore()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    private func updateScore() {
        scoreStream.score
            .subscribe(onNext: { (score: Score) in
                self.presenter.set(score: score)
            })
            .disposeOnDeactivate(interactor: self)
    }
}
