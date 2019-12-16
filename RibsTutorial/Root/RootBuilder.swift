//
//  RootBuilder.swift
//  RibsTutorial
//
//  Created by DUCHV3 on 12/16/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
//    func build(withListener listener: RootListener) -> RootRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)

        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          loggedOutBuilder: loggedOutBuilder)
    }

//    func build(withListener listener: RootListener) -> RootRouting {
//        let component = RootComponent(dependency: dependency)
//        let viewController = RootViewController()
//        let interactor = RootInteractor(presenter: viewController)
//        interactor.listener = listener
//        return RootRouter(interactor: interactor, viewController: viewController)
//    }
}
