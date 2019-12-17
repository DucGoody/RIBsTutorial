//
//  RootComponent+LoggedOut.swift
//  RibsTutorial
//
//  Created by DUCHV3 on 12/17/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs

protocol RootDependencyLoggedOut: Dependency {

    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the LoggedOut scope.
}

extension RootComponent: LoggedOutDependency {

    // TODO: Implement properties to provide for LoggedOut scope.
}
