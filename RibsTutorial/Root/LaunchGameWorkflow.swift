//
//  LaunchGameWorkflow.swift
//  RibsTutorial
//
//  Created by HoangVanDuc on 12/18/19.
//  Copyright © 2019 DUCHV3. All rights reserved.
//

import RIBs
import RxSwift

public class LaunchGameWorkflow: Workflow<RootActionableItem> {
    public init(url: URL) {
        super.init()
        
        let gameId = parseGameId(from: url)
        self.onStep { (rootItem) -> Observable<(LoggedInActionableItem, ())> in
            rootItem.waitForLogin()
        }.onStep { (loggedInItem, _) -> Observable<(LoggedInActionableItem, ())> in
            loggedInItem.launchGame(with: gameId)
        }.commit()
    }
    
    private func parseGameId(from url: URL) -> String? {
        let components = URLComponents.init(string: url.absoluteString)
        let items = components?.queryItems ?? []
        
        for item in items {
            if item.name == "gameId" {
                return item.value
            }
        }
        
        return nil
    }
}
