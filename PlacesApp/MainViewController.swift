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
