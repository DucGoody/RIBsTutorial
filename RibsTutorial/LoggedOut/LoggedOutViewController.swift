//
//  LoggedOutViewController.swift
//  RibsTutorial
//
//  Created by DUCHV3 on 12/17/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
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
    
    @IBOutlet weak var player2TextField: UITextField!
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad LoggedOutViewController")
        
        loginButton.rx.tap.asDriver()
            .drive(onNext: { [unowned self] in
                self.listener?.login(withPlayer1Name: self.player1TextField.text, player2Name: self.player2TextField.text)
            }).disposed(by: bag)
    }
}
