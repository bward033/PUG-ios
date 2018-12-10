//
//  Resources.swift
//  pug-ios
//
//  Created by Bryan Ward & Jeffrey Bahns on 4/21/17.
//  Copyright © 2017 Bryan Ward & Jeffrey Bahns. All rights reserved.
//

import Foundation

// globals for accessing API
struct API {
    static let base_url_local = "http://localhost:3000/api"
    static let base_url = "https://enigmatic-tundra-24206.herokuapp.com/api"
    static let auth_url = base_url + "/authenticate"
    static let auth_local_url = base_url_local + "/authenticate"

    static let all_players = API.base_url + "/all_players"
    
    static let all_courts = API.base_url + "/all_courts"
    static let some_courts = API.base_url + "/courts"
    static let some_courts_local = API.base_url_local + "/courts"
    

    static let players_in_game = "/players_in_game?GameID="
    static let player_by_id = "/player_by_id?PlayerID="
    
    // game
        static let all_games = API.base_url + "/all_games"
    static let insert_game = "/insert_game"
    static let games_in_court = "/games_in_court?CourtID="
    static let join_game = "/join_game"
}

// globals set here for all database structures
// in case they are changed, they can be easily modified here
struct GameAPI {
    static let game_date_time = "GameDateTime"
    static let game_name = "GameName"
    static let game_duration = "GameDuration"
    static let game_skill_level = "SkillLevel"
    static let game_id = "GameID"
    static let game_court_id = "CourtID"
    static let game_player_id = "CreatorID"
}

struct CourtAPI {
    static let court_name = "CourtName"
    static let court_address = "Address"
    static let court_city = "City"
    static let court_state = "State"
    static let court_zip = "ZipCode"
    static let court_id = "CourtID"
    static let court_coord_lat = "Latitude"
    static let court_coord_long = "Longitude"
    static let court_distance_mi = "Distance"
    static let court_image = "Image"
    
}

struct PlayerAPI {
    static let player_username = "Username"
    static let player_first_name = "FirstName"
    static let player_last_name = "LastName"
    static let player_password = "Password"
    static let player_phone_number = "PhoneNumber"
    static let player_age = "Age"
    static let player_id = "PlayerID"
    static let player_image = "Image"
}

struct AuthResponseAPI {
    static let auth_response = "response"
    static let auth_resopnse_success = "pass"
    static let auth_resopnse_failure = "fail"
    static let auth_response_user = "user"
}

struct Locations {
    // sonoma state
    static let ssu_lat = 38.3394
    static let ssu_long = -122.6742
}

