//
//  UserTableViewController.swift
//  pug-ios
//
//  Created by Bryan Ward & Jeffrey Bahns on 5/3/17.
//  Copyright © 2017 Bryan Ward & Jeffrey Bahns. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    var playerData: APIAssistant = APIAssistant()
    var playerDS: PlayerDataSource?
    var gameID: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        playerData.addObserver(self, forKeyPath: "dataFromServer", options: .old, context: nil)
        self.playerData.players_in_game_request(gameID: self.gameID!)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("Data \(playerData.data()!)")
        self.playerDS = PlayerDataSource(dataSource: playerData.data()!)
        print("shit:\(playerDS?.players)")
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    
    deinit {
        playerData.removeObserver(self, forKeyPath: "dataFromServer", context: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pds = playerDS {
            return pds.numPlayers()
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        if let theCell = cell as? UserTableViewCell, let player = playerDS?.playerAt(indexPath.row) {
            
            theCell.useUser(player)
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UserTableViewCell
        if let indexPath = tableView.indexPath(for: cell), let ds = playerDS {
            let userVC = segue.destination as! UserViewController
            userVC.userForThisView(user: ds.playerAt(indexPath.row))
        }
    }
 

}
