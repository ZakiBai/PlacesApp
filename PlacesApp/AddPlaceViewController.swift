//
//  AddPlaceViewController.swift
//  PlacesApp
//
//  Created by Zaki on 27.09.2023.
//

import UIKit
import RealmSwift
class AddPlaceViewController: UITableViewController {

    var imageIsChanged = false
    
    @IBOutlet var placeImage: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var placeName: UITextField!
    @IBOutlet var placeLocation: UITextField!
    @IBOutlet var placeType: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        saveButton.isEnabled = false
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let cameraIcon = UIImage(named: "camera")
            let photoIcon = UIImage(named: "photo")
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photoLibrary = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photoLibrary.setValue(photoIcon, forKey: "image")
            photoLibrary.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photoLibrary)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func saveNewPlace() {
        
        var image: UIImage?
        
        if imageIsChanged {
            image = placeImage.image
        } else {
            image = UIImage(named: "imagePlaceholder")
        }

        let imageData = image?.pngData()
        
        let newPlace = Place(nameLabel: placeName.text!,
                             imageData: imageData,
                             locationLabel: placeLocation.text,
                             typeLabel: placeType.text)
        
        StorageManager.saveObject(newPlace)
    }
    
}

extension AddPlaceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

extension AddPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        
        imageIsChanged = true
        
        dismiss(animated: true)
    }
}
