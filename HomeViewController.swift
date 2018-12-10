//
//  HomeViewController.swift
//  pug-ios
//
//  Created by Bryan Ward & Jeffrey Bahns on 4/20/17.
//  Copyright © 2017 Bryan Ward & Jeffrey Bahns. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class HomeViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dock: UIToolbar!

    let playerCD = PlayerCoreData()
    let manager = CLLocationManager()
    var selectedCourt: CourtAnnotation? = nil
    
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    
    var apiAssistant: APIAssistant?
    var courtDS: CourtDataSource?
    
    
    @IBOutlet weak var nearbyButton: UIBarButtonItem!
    @IBOutlet weak var addNewButton: UIBarButtonItem!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        apiAssistant = APIAssistant()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        mapView.delegate = self
        
        
        // search table shit
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTableViewController") as! LocationSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
         
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToUser" {
            var userVC = segue.destination as! UserViewController
            self.playerCD.getUserCoreData()
            userVC.userID = self.playerCD.getPlayerID()
        }
        
        if segue.identifier == "courtPinToCourt" {
            let courtVC = segue.destination as! CourtViewController
            courtVC.courtForThisView(court: (selectedCourt?.court)!)
        }
        
        if segue.identifier == "homeToAddGame" {
            let addGameVC = segue.destination as! AddGameViewController
            addGameVC.courtDSForThisView(courtDS: self.courtDS!)
        }
        
     }
 
}




