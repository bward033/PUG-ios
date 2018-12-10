//
//  NearbyTableViewController.swift
//  pug-ios
//
//  Created by Bryan Ward & Jeffrey Bahns on 5/1/17.
//  Copyright © 2017 Bryan Ward & Jeffrey Bahns. All rights reserved.
//

import UIKit
import CoreLocation

class NearbyTableViewController: UITableViewController {
    var courtData: APIAssistant?
    var courtDS: CourtDataSource?
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.courtData = APIAssistant()
        courtData?.addObserver(self, forKeyPath: "dataFromServer", options: .old, context: nil)
        self.courtData?.locations_request(origin_lat: Locations.ssu_lat,
                                          origin_long: Locations.ssu_long,
                                          radius: 100)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestLocation()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.courtDS = CourtDataSource(dataSource: (courtData?.data()!)!)
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    
    deinit {
        courtData?.removeObserver(self, forKeyPath: "dataFromServer", context: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cds = courtDS {
            return cds.numCourts()
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourtCell", for: indexPath)

        if let theCell = cell as? CourtTableViewCell, let court = courtDS?.courtAt(indexPath.row) {
            theCell.useCourt(court)
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
        if segue.identifier == "courtCellToCourt" {
            let cell = sender as! CourtTableViewCell
            if let indexPath = tableView.indexPath(for: cell), let ds = courtDS {
                print("pressed court cell: \(indexPath.row)")
                let courtVC = segue.destination as! CourtViewController
                courtVC.courtForThisView(court: ds.courtAt(indexPath.row))
            }
        }
    }
    
}

extension NearbyTableViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let radius = Double(15)
            let delta = radius / 69.0
            
        }
    }
    
}
