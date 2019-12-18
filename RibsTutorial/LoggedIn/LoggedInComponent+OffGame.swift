//
//  LoggedInComponent+OffGame.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/17/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
/// The dependencies needed from the parent scope of LoggedIn to provide for the OffGame scope.
// TODO: Update LoggedInDependency protocol to inherit this protocol.
protocol LoggedInDependencyOffGame: Dependency {

    // TODO: Declare dependencies needed from the parent scope of LoggedIn to provide dependencies
    // for the OffGame scope.
}

extension LoggedInComponent: OffGameDependency {
    var scoreStream: ScoreStream {
        return mutableScoreStream
    }
    // TODO: Implement properties to provide for OffGame scope.
}
