//
//  ViewController.swift
//  PracticeIOSVenture1
//
//  Created by MD Tanvir Alam on 11/2/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var itemArray = [Data]()
    
    @IBOutlet weak var itemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let nib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        //itemTableView.register(nib, forCellReuseIdentifier: "ItemTableViewCell")
        itemTableView.delegate = self
        itemTableView.dataSource = self
        
        refreashData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreashData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCell", for: indexPath) as! PrototypeCell
        let decoder = JSONDecoder()
        if let item = try? decoder.decode(ItemModel.self, from: itemArray[indexPath.row]) {
            cell.itemNo.text = String(indexPath.row + 1)
            cell.itemDescription.text = item.description
            cell.itemImage.image = UIImage(data: item.image)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSague", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSague"{
            let indexPath = self.itemTableView.indexPathForSelectedRow!
            let vc = segue.destination as! AddItemViewController
            vc.isDetail = true
            vc.detailNo = indexPath.row
        }
    }
    
    func refreashData(){
        if let items = UserDefaults.standard.array(forKey: "ItemArray") as? [Data]{
            itemArray = items
        }
        
        itemTableView.reloadData()
    }
}

