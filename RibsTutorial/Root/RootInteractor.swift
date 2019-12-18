//
//  RootInteractor.swift
//  RibsTutorial
//
//  Created by DUCHV3 on 12/16/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
import RxSwift

public protocol RootActionableItem: class {
    func waitForLogin() -> Observable<(LoggedInActionableItem, ())>
}

public protocol LoggedInActionableItem: class {
    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, ())>
}

protocol RootRouting: ViewableRouting {
    func routeToLoggedIn(withPlayer1Name player1Name: String, player2Name: String) -> LoggedInActionableItem
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener, UrlHandler, RootActionableItem {
    
    weak var router: RootRouting?
    weak var listener: RootListener?
    private let loggedInActionableItemSubject = ReplaySubject<LoggedInActionableItem>.create(bufferSize: 1)

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
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
    
    // UrlHandler
    func handle(_ url: URL) {
        let launchGameWorkflow = LaunchGameWorkflow(url: url)
        launchGameWorkflow
            .subscribe(self)
            .disposeOnDeactivate(interactor: self)
    }
    
    // RootActionableItem
    func waitForLogin() -> Observable<(LoggedInActionableItem, ())> {
        return loggedInActionableItemSubject.map { (loggedInItem) -> (LoggedInActionableItem, ()) in
            (loggedInItem,())
        }
    }
    
    func didLogin(withPlayer1Name player1Name: String, player2Name: String) {
        let loggedInActionableItem = router?.routeToLoggedIn(withPlayer1Name: player1Name, player2Name: player2Name)
        if let loggedInActionableItem = loggedInActionableItem {
            loggedInActionableItemSubject.onNext(loggedInActionableItem)
        }
    }
}
