//
//  TicTacToeAdapter.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/18/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs

class TicTacToeAdapter: Game, GameBuildable, TicTacToeListener {
    
    let id = "tictactoe"
    let name = "Tic Tac Toe"
    let ticTacToeBuilder: TicTacToeBuilder
    weak var gameListener: GameListener?
    
    var builder: GameBuildable {return self}
    
    init(dependency: TicTacToeDependency) {
        ticTacToeBuilder = TicTacToeBuilder.init(dependency: dependency)
    }
    
    func build(withListener listener: GameListener) -> ViewableRouting {
        gameListener = listener
        return ticTacToeBuilder.build(withListener: self)
    }
    
    func ticTacToeDidEnd(with winner: PlayerType?) {
        gameListener?.gameDidEnd(with: winner)
    }
}
