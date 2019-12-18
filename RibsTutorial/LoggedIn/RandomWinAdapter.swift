//
//  RandomWinAdapter.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/18/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
class RandomWinAdapter: Game, GameBuildable, RandomWinListener {

    let id = "randomwin"
    let name = "Random Win"
    var builder: GameBuildable {
        return self
    }

    private let randomWinBuilder: RandomWinBuilder

    private weak var listener: GameListener?

    init(dependency: RandomWinDependency) {
        randomWinBuilder = RandomWinBuilder(dependency: dependency)
    }

    func build(withListener listener: GameListener) -> ViewableRouting {
        self.listener = listener
        return randomWinBuilder.build(withListener: self)
    }

    func didRandomlyWin(with player: PlayerType) {
        listener?.gameDidEnd(with: player)
    }
}
