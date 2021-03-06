//
//  GameTableViewController.swift
//  pug-ios
//
//  Created by Bryan Ward & Jeffrey Bahns on 5/3/17.
//  Copyright © 2017 Bryan Ward & Jeffrey Bahns. All rights reserved.
//

import UIKit

class GameTableViewController: UITableViewController {
    var gameData: APIAssistant = APIAssistant()
    var gameDS: GameDataSource?
    var courtID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        gameData.addObserver(self, forKeyPath: "dataFromServer", options: .old, context: nil)
        self.gameData.games_in_court_request(courtID: self.courtID!)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //print("Data \(gameData.data()!)")
        self.gameDS = GameDataSource(dataSource: gameData.data()!)
        
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }

    deinit {
        gameData.removeObserver(self, forKeyPath: "dataFromServer", context: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let gds = gameDS {
            return gds.numGames()
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        
        if let theCell = cell as? GameTableViewCell, let game = gameDS?.gameAt(indexPath.row) {
            theCell.useGame(game)
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! GameTableViewCell
        if let indexPath = tableView.indexPath(for: cell), let ds = gameDS {
            let gameVC = segue.destination as! GameViewController
            gameVC.gameForThisView(game: ds.gameAt(indexPath.row))
        }

    }
 

}
