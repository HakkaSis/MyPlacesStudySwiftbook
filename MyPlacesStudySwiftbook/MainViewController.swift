//
//  MainViewController.swift
//  MyPlacesStudySwiftbook
//
//  Created by Евгений Скилиоти on 15.05.2020.
//  Copyright © 2020 Евгений Скилиоти. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var places: Results<Place>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)

    }

    // MARK: - Table view data source

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let place = places[indexPath.row]

        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)

        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true

        return cell
    }
    
           // MARK: - Table view delegate
       func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let place = places[indexPath.row]
            let contextItem = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in
                StorageManager.deleteObject(place)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
            
            return swipeActions
        }
        
        
     
    //     MARK: - Navigation


        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetail" {
                guard let indexPath = tableView.indexPathForSelectedRow else { return }
                let place = places[indexPath.row]
                guard let newPlaceVC = segue.destination as? NewPlaceViewController else { return }
                newPlaceVC.currentPlace = place
            }
        }
    
    @IBAction func unwingSegue(_ segue: UIStoryboardSegue) {
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        
        newPlaceVC.savePlace()
        tableView.reloadData()
    }

 

}
