//
//  RandomWinViewController.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/18/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import SnapKit
import UIKit

protocol RandomWinPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func determineWinner()
}

final class RandomWinViewController: UIViewController, RandomWinPresentable, RandomWinViewControllable {

    weak var listener: RandomWinPresentableListener?
    private let player1Name: String
    private let player2Name: String
    
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
        view.backgroundColor = .cyan
        buildGoButton()
    }
    
    func announce(winner: PlayerType, withCompletionHandler handler: @escaping () -> ()) {
        let winnerString: String = {
            switch winner {
            case .player1:
                return "\(player1Name) Won!"
            case .player2:
                return "\(player2Name) Won!"
            }
        }()
        let alert = UIAlertController(title: winnerString, message: nil, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "That was random...", style: .default) { _ in
            handler()
        }
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func buildGoButton() {
        let button = UIButton()
        button.setTitle("Magic", for: .normal)
        button.backgroundColor = UIColor.purple
        button.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.center.equalTo(self.view.snp.center)
            maker.leading.trailing.equalTo(self.view).inset(20)
            maker.height.equalTo(100)
        }

        button.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.determineWinner()
            })
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()
}
