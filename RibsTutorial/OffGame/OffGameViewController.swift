//
//  OffGameViewController.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/17/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol OffGamePresentableListener: class {
   func start(_ game: Game)
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
//    func set(score: Score) {
//        self.score = score
//    }
//
    weak var listener: OffGamePresentableListener?
//    @IBOutlet weak var startGameButton: UIButton!
    
    private let disposeBag = DisposeBag()
//    private let player1Name: String
//    private let player2Name: String
//    private var score: Score?
    private let games: [Game]
    
    var uiviewController: UIViewController {
        return self
    }
    
    init(games: [Game]) {
        self.games = games
         super.init(nibName: nil, bundle: nil)
    }
    
//    init(player1Name: String, player2Name: String) {
//        self.player1Name = player1Name
//        self.player2Name = player2Name
//        super.init(nibName: nil, bundle: nil)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    func show(scoreView scoreBoardView: ViewControllable) {
        addChild(scoreBoardView.uiviewController)
        view.addSubview(scoreBoardView.uiviewController.view)
        scoreBoardView.uiviewController.view.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(70)
            maker.leading.trailing.equalTo(self.view).inset(20)
            maker.height.equalTo(120)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        startGameButton.rx.tap
//        .subscribe(onNext: { [weak self] in
//            self?.listener?.start(games)
//        })
//        .disposed(by: disposeBag)
        view.backgroundColor = UIColor.yellow
        buildStartButtons()
    }
    
    func buildStartButtons() {
        var previousButton: UIView?
        for game in games {
            previousButton = buildStartButton(with: game, previousButton: previousButton)
        }
    }
    
    private func buildStartButton(with game: Game, previousButton: UIView?) -> UIButton {
        let startButton = UIButton()
        view.addSubview(startButton)
        startButton.accessibilityIdentifier = game.name
        startButton.snp.makeConstraints { (maker: ConstraintMaker) in
            if let previousButton = previousButton {
                maker.bottom.equalTo(previousButton.snp.top).offset(-20)
            } else {
                maker.bottom.equalTo(self.view.snp.bottom).inset(30)
            }
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(50)
        }
        startButton.setTitle(game.name, for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.backgroundColor = UIColor.black
        startButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.start(game)
            })
            .disposed(by: disposeBag)

        return startButton
    }
}
