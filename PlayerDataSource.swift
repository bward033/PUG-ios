//
//  PlayerDataSource.swift
//  pug-ios
//
//  Created by Bryan Ward & Jeffrey Bahns on 4/18/17.
//  Copyright © 2017 Bryan Ward & Jeffrey Bahns. All rights reserved.
//

import Foundation

import UIKit

class PlayerDataSource: NSObject {
    
    var players: [AnyObject]
    
    init(dataSource: [AnyObject]) {
        self.players = dataSource
        super.init()
    }
    
    func numPlayers() -> Int{
        return players.count
    }
    
    func playerAt(_ index: Int) -> Player {
        let player = Player( player: self.players[index] )
        return player
    }
}
