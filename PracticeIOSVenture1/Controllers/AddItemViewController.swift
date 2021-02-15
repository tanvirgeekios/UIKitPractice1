//
//  AddItemViewController.swift
//  PracticeIOSVenture1
//
//  Created by MD Tanvir Alam on 11/2/21.
//

import UIKit

class AddItemViewController: UIViewController {
    var isDetail = false
    var detailNo = 0
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var itemArray = [Data]()
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AddItemViewController connected")
        // Do any additional setup after loading the view.
        refreashItemArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isDetail == true{
            let decoder = JSONDecoder()
            if let item = try? decoder.decode(ItemModel.self, from: itemArray[detailNo]){
                pickedImage.image = UIImage(data: item.image)
                descriptionText.text = item.description
            }
            title = "Detail View"
            saveButton.title = "Update"
        }
    }
    
    @IBAction func uploadImageBtn(_ sender: UIButton) {
        print("upload Image Button Clicked")
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func saveButtonClick(_ sender: UIBarButtonItem) {
        print("Save button Clicked")
      
        if (!description.isEmpty && pickedImage.image != nil){
            let imageData = pickedImage.image!.pngData()
            let newItem = ItemModel(image: imageData!, description: descriptionText.text)
            do {
                // Create JSON Encoder
                let encoder = JSONEncoder()
                
                // Encode item
                let data = try encoder.encode(newItem)
                if isDetail{
                    itemArray[detailNo] = data
                }else{
                    itemArray.append(data)
                }
                
                // Write/Set Data
                UserDefaults.standard.set(itemArray, forKey: "ItemArray")
                _ = navigationController?.popViewController(animated: true)
            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
        
        
        
        
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        if isDetail{
            print("Delete Button Cliked")
            print(itemArray.count)
            itemArray.remove(at: detailNo)
            print(itemArray.count)
            pickedImage.image = nil
            descriptionText.text = ""
            UserDefaults.standard.set(itemArray, forKey: "ItemArray")
            refreashItemArray()
        }else{
            
        }
        
    }
    func refreashItemArray(){
        if let items = UserDefaults.standard.array(forKey: "ItemArray") as? [Data]{
            itemArray = items
        }
    }

}
//Pick Image
extension AddItemViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            pickedImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
