//
//  MainViewController.swift
//  PlacesApp
//
//  Created by Zaki on 21.09.2023.
//

import UIKit

class MainViewController: UITableViewController {
    
    let places = Place.getPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.nameLabel?.text = places[indexPath.row].nameLabel
        cell.locationLabel.text = places[indexPath.row].locationLabel
        cell.typeLabel.text = places[indexPath.row].typeLabel
        cell.imageOfPlace?.image = UIImage(named: places[indexPath.row].imageOfPlace)
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {}

}
