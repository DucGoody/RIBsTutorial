//
//  LoggedOutViewController.swift
//  RibsTutorial
//
//  Created by DUCHV3 on 12/17/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol LoggedOutPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func login(withPlayer1Name player1Name: String?, player2Name: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
    weak var listener: LoggedOutPresentableListener?
    private var player1Field: UITextField!
    private var player2Field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let playerFields = buildPlayerFields()
        buildLoginButton(withPlayer1: playerFields.player1Field, withPlayer2: playerFields.player2Field)
        let view = self.view
    }
    
    private func buildPlayerFields() -> (player1Field: UITextField, player2Field: UITextField) {
        let player1Field = UITextField()
        self.player1Field = player1Field
        player1Field.borderStyle = .line
        view.addSubview(player1Field)
        player1Field.placeholder = "Player 1 name"
        player1Field.snp.makeConstraints { (view) in
            view.top.equalTo(self.view).offset(100)
            view.leading.trailing.equalTo(self.view).inset(40)
            view.height.equalTo(40)
        }
        
        let player2Field = UITextField()
        self.player2Field = player2Field
        player2Field.borderStyle = .line
        view.addSubview(player2Field)
        player2Field.placeholder = "Player 2 name"
        player2Field.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player1Field.snp.bottom).offset(20)
            maker.left.right.height.equalTo(player1Field)
        }
        
        return (player1Field, player2Field)
    }
    
    private func buildLoginButton(withPlayer1: UITextField,withPlayer2: UITextField) {
        let loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (view) in
            view.top.equalTo(player2Field.snp.bottom).offset(20)
            view.left.right.height.equalTo(player1Field)
        }
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    @objc private func didTapLogin(){
        listener?.login(withPlayer1Name: player1Field?.text, player2Name: player2Field?.text)
    }
}
