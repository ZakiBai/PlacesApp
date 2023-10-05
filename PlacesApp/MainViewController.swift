//
//  MainViewController.swift
//  PlacesApp
//
//  Created by Zaki on 21.09.2023.
//

import UIKit
import RealmSwift
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var places: Results<Place>!
    private var ascendingSorting = true
    private var filteredPlaces: Results<Place>!
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
   
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var reversedSortingButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        places = realm.objects(Place.self)
 
        // Setup the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPlaces.count
        }
        return places.isEmpty ? 0 : places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        var place = Place()
        if isFiltering {
            place = filteredPlaces[indexPath.row]
        } else {
            place = places[indexPath.row]
        }
        
        cell.nameLabel?.text = place.nameLabel
        cell.locationLabel.text = place.locationLabel
        cell.typeLabel.text = place.typeLabel
        cell.imageOfPlace.image = UIImage(data: place.imageData!)
        
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
    // Можем использовать данный метод, для одного действия он избыточен
    //    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //        let place = places[indexPath.row]
    //
    //        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
    //            StorageManager.deleteObject(place)
    //            tableView.deleteRows(at: [indexPath], with: .automatic)
    //        }
    //
    //        return UISwipeActionsConfiguration(actions: [deleteAction])
    //    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let place = places[indexPath.row]
            StorageManager.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let addPlaceVC = segue.destination as! AddPlaceViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let place: Place
            if isFiltering {
                place = filteredPlaces[indexPath.row]
            } else {
                place = places[indexPath.row]
            }
            addPlaceVC.currentPlace = place
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let addPlaceVC = segue.source as? AddPlaceViewController else { return }
        addPlaceVC.savePlace()
        tableView.reloadData()
    }
    
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        sorting()
    }
    
    @IBAction func reversedSorting(_ sender: UIBarButtonItem) {
        ascendingSorting.toggle()
        if ascendingSorting {
            reversedSortingButton.image = UIImage(named: "AZ")
        } else {
            reversedSortingButton.image = UIImage(named: "ZA")
        }
        
        sorting()
    }
    
    private func sorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            places = places.sorted(byKeyPath: "nameLabel", ascending: ascendingSorting)
        }
        
        tableView.reloadData()
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredPlaces = places.filter("nameLabel CONTAINS[c] %@ OR locationLabel CONTAINS[c] %@", searchText, searchText)
        
        tableView.reloadData()
    }
}
