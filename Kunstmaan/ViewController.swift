//
//  ViewController.swift
//  Kunstmaan
//
//  Created by Kurt Warson on 06/07/2018.
//  Copyright © 2018 Kurt Warson. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
      let URL_GET_DATA = "https://www.cocoonplace.com/be/kunstmaan10.php"
    
    @IBOutlet weak var MaanTableView: UITableView!
    
    var manen = [Maan]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! MaanTableViewCell
        
        //getting the hero for the specified position
        let maan: Maan
        maan = manen[indexPath.row]
        
        cell.Beschrijving1.text = maan.beschrijving
        
        cell.Beschrijving2.text = maan.beschrijving2
        
        Alamofire.request(maan.imageUrl1!).responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                cell.AchtergrondImage.image = image
            }
        }
        
        Alamofire.request(maan.imageUrl2!).responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                cell.cloudyImage.image = image
            }
        }
        
        
        return cell
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         MaanTableView.rowHeight = 300
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                let heroesArray : NSArray  = json as! NSArray
                
                //traversing through all elements of the array
                for i in 0..<heroesArray.count{
                    
                    //adding hero values to the hero list
                    self.manen.append(Maan(
                        beschrijving: (heroesArray[i] as AnyObject).value(forKey: "Beschrijving") as? String,
                        beschrijving2: (heroesArray[i] as AnyObject).value(forKey: "Beschrijving2") as? String,
                        
                        imageUrl1: (heroesArray[i] as AnyObject).value(forKey: "Image1") as? String,
                        
                        imageUrl2: (heroesArray[i] as AnyObject).value(forKey: "Image2") as? String
                        
                       
                    ))
                    
                }
                
                //displaying data in tableview
                self.MaanTableView.reloadData()
            }
            
        }
        
        
        
        self.MaanTableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        
        let more =
            
            UITableViewRowAction(style: .normal, title: "\u{2606}\n Markeer als betaald") { action, index in
                print("Stock Picked")
                
                let cell = self.MaanTableView.cellForRow(at: index) as? MaanTableViewCell
                
//                cell?.Beschrijving1.backgroundColor = UIColor.yellow
                
                var image : UIImage = UIImage(named: "cloudsun")!
                
                cell?.cloudyImage?.image = image
                
        }
        more.backgroundColor = .yellow
        
        let less =
            
            UITableViewRowAction(style: .normal, title: "\u{2606}\n Markeer als niet gepland") { action, index in
                print("Stock Picked")
                
                let cell = self.MaanTableView.cellForRow(at: index) as? MaanTableViewCell
                
                //                cell?.Beschrijving1.backgroundColor = UIColor.yellow
                
                var image : UIImage = UIImage(named: "cloudsky")!
                
                cell?.cloudyImage?.image = image
                
        }
        less.backgroundColor = UIColor.green
        
        
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Verwijder") { (action, indexPath) in
            self.removeAnimalAtIndex(index: indexPath.row)
            // "close" the swipe (1)
            self.MaanTableView.setEditing(false, animated: true)
            
            //handle delete
        }
        deleteAction.backgroundColor = UIColor.orange
        
        return [less, more, deleteAction]
    }
    
    
    
        
    func removeAnimalAtIndex(index: Int) {
        // remove the animal in the model.
        manen.remove(at: index)
        // fancy animation to delete the row
        MaanTableView.beginUpdates()
        MaanTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        MaanTableView.endUpdates()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

