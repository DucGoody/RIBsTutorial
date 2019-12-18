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
    func startGame()
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
    func set(score: Score) {
        self.score = score
    }
    
    weak var listener: OffGamePresentableListener?
    @IBOutlet weak var startGameButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let player1Name: String
    private let player2Name: String
    private var score: Score?
    
    var uiviewController: UIViewController {
        return self
    }
    
    init(player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGameButton.rx.tap
        .subscribe(onNext: { [weak self] in
            self?.listener?.startGame()
        })
        .disposed(by: disposeBag)
    }
}
