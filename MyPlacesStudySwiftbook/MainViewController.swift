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
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var places: Results<Place>!
    private var filteredPlace: Results<Place>!
    private var ascendingSorting = true
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var reversedSortingButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
    // MARK: - setup the search conroller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
//        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
    if isFiltering {
        return filteredPlace.count
    }
        return places.isEmpty ? 0 : places.count
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        var place = Place()
        
    if isFiltering {
        place = filteredPlace[indexPath.row]
    } else {
        place = places[indexPath.row]
    }
        

        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)

        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true

        return cell
    }
    
           // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
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
                let place: Place
                if isFiltering {
                    place = filteredPlace[indexPath.row]
                } else {
                    place = places[indexPath.row]
                }
                guard let newPlaceVC = segue.destination as? NewPlaceViewController else { return }
                newPlaceVC.currentPlace = place
            }
        }
    
    @IBAction func unwingSegue(_ segue: UIStoryboardSegue) {
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        
        newPlaceVC.savePlace()
        tableView.reloadData()
    }

    @IBAction func sortSelection(_ sender: UISegmentedControl) {
       
        sorting()

    }
    

    @IBAction func reverseSorting(_ sender: Any) {
        ascendingSorting.toggle()
        
        if ascendingSorting {
            reversedSortingButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            reversedSortingButton.image = #imageLiteral(resourceName: "ZA")
        }
        
        sorting()
    }
    
    private func sorting() {
        if segmentedControll.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            places = places.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        tableView.reloadData()
    }
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredPlace = places.filter("name CONTAINS[c] %@ OR location CONTAINS[c] %@ OR type CONTAINS[c] %@", searchText, searchText, searchText)
        
        tableView.reloadData()
    }
    
    
}
