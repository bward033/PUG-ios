//
//  GameDataSource.swift
//  pug-ios
//
//  Created by Bryan Ward & Jeffrey Bahns on 4/18/17.
//  Copyright © 2017 Bryan Ward & Jeffrey Bahns. All rights reserved.
//

import Foundation

import UIKit

class GameDataSource: NSObject {
    
    var games: [AnyObject]
    
    init(dataSource: [AnyObject]) {
        self.games = dataSource
        super.init()
    }
    
    func numGames() -> Int{
        return games.count
    }
    
    func gameAt(_ index: Int) -> Game {
        let game = Game( game: self.games[index] )
        return game
    }
}
