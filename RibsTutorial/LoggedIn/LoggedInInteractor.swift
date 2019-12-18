//
//  LoggedInInteractor.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/17/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
import RxSwift

protocol LoggedInRouting: Routing {
    func cleanupViews()
    func routeToOffGame(with games: [Game])
    func routeToGame(with gameBuilder: GameBuildable)
}

protocol LoggedInListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable, LoggedInActionableItem {
    func startTicTacToe() {
        
    }
    

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?
    private let mutableScoreStream: MutableScoreStream
    private var games = [Game]()
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
//    override init() {
//        
//    }
    
    init(mutableScoreStream: MutableScoreStream) {
        self.mutableScoreStream = mutableScoreStream
    }
    
    init(games: [Game]) {
        self.games = games
        super.init()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.routeToOffGame(with: games)
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    func gameDidEnd(withWinner winner: PlayerType?) {
        router?.routeToOffGame(with: games)
    }
    
    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, ())> {
        let game: Game? = games.first { game in
            return game.id.lowercased() == id?.lowercased()
        }

        if let game = game {
            router?.routeToGame(with: game.builder)
        }

        return Observable.just((self, ()))
    }
}
