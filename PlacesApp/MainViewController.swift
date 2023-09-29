//
//  MainViewController.swift
//  PlacesApp
//
//  Created by Zaki on 21.09.2023.
//

import UIKit
import RealmSwift
class MainViewController: UITableViewController {
    
    var places: Results<Place>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return places.isEmpty ? 0 : places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let place = places[indexPath.row]

        cell.nameLabel?.text = place.nameLabel
        cell.locationLabel.text = place.locationLabel
        cell.typeLabel.text = place.typeLabel
        cell.imageOfPlace.image = UIImage(data: place.imageData!)
        
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let place = places[indexPath.row]
            StorageManager.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let addPlaceVC = segue.source as? AddPlaceViewController else { return }
        addPlaceVC.saveNewPlace()
        tableView.reloadData()
    }
}
