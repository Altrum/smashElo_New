//
//  PlayerObject.swift
//  Smash Elo
//
//  Created by Robert Chung on 1/3/17.
//  Copyright © 2017 Robert Chung. All rights reserved.
//

// ================================================= //
// Keep track of the player -- elo, name, email, etc //
// ================================================= //

import UIKit

class PlayerObject: NSObject {
    
    var name: String = "Player"
    var email: String? = "No Email"
    var careerElo: Int?
    var careerWins: Int?
    var careerLosses: Int?
    var careerTotalGames: Int?
    var matches: Array<String>?
    // var profilePic:
    // var storyPic:
    
    override init(){
        super.init()
        
        // does it really start at 1200? Check
        // TODO
        careerElo = 1200
        careerWins = 0
        careerLosses = 0
        careerTotalGames = 0
        
    }
    
    init(name: String, email: String){
        
        // does it really start at 1200? Check
        // TODO
        self.name = name
        self.email = email
        careerElo = 1200
        careerWins = 0
        careerLosses = 0
        careerTotalGames = 0

        
    }
    
    
    
}
