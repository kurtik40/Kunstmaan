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

        let maan: Maan
        maan = manen[indexPath.row]
        
        cell.Beschrijving1.text = maan.beschrijving
        
        cell.Beschrijving2.text = "€ " + maan.beschrijving2!
        
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
        
      
        MaanTableView.rowHeight = 280
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                let heroesArray : NSArray  = json as! NSArray
                
                //traversing through all elements of the array
                for i in 0..<heroesArray.count{
                    
                  
                    self.manen.append(Maan(
                        beschrijving: (heroesArray[i] as AnyObject).value(forKey: "Beschrijving") as? String,
                        beschrijving2: (heroesArray[i] as AnyObject).value(forKey: "Beschrijving2") as? String,
                        
                        imageUrl1: (heroesArray[i] as AnyObject).value(forKey: "Image1") as? String,
                        
                        imageUrl2: (heroesArray[i] as AnyObject).value(forKey: "Image2") as? String
                        
                    ))
                    
                }
                
                self.MaanTableView.reloadData()
            }
        }
        
        self.MaanTableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        
        let more =

                    UITableViewRowAction(style: .normal, title: "") { action, index in
                        print("Stock Picked")

                        let cell = self.MaanTableView.cellForRow(at: index) as? MaanTableViewCell

                        var image : UIImage = UIImage(named: "cloudeuro")!

                        cell?.cloudyImage?.image = image

                }
        
        more.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundtest")!)

                let less =

                    UITableViewRowAction(style: .normal, title: "") { action, index in
                        print("Stock Picked")

                        let cell = self.MaanTableView.cellForRow(at: index) as? MaanTableViewCell

                        var image : UIImage = UIImage(named: "yellowcloud")!

                        cell?.cloudyImage?.image = image

                }
        less.backgroundColor = UIColor(patternImage: UIImage(named: "greenbackground")!)
        
       
        let deleteAction = UITableViewRowAction(style: .destructive, title: "") { (action, indexPath) in
            self.removeAnimalAtIndex(index: indexPath.row)
            // "close" the swipe (1)
            self.MaanTableView.setEditing(false, animated: true)

            //handle delete
        }
        deleteAction.backgroundColor = UIColor(patternImage: UIImage(named: "orangebackground")!)
        
        return [less, more, deleteAction]
    }
    
    
    func removeAnimalAtIndex(index: Int) {
      
        manen.remove(at: index)
     
        MaanTableView.beginUpdates()
        MaanTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        MaanTableView.endUpdates()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
   
}

//    func contextualDeleteAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
//        let action = UIContextualAction(style: .destructive, title: "Delete") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
//            print("Deleting")
//            self.manen.remove(at: indexPath.row)
//            self.MaanTableView.deleteRows(at: [indexPath], with: .left)
//            completionHandler(true)
//        }
//
//        return action
//    }
//
//    func contextualToggleFlagAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
//
//       let action =  UIContextualAction(style: .destructive, title: "Markeer als betaald") { (action, view, handler) in
//        let cell = self.MaanTableView.cellForRow(at: indexPath) as? MaanTableViewCell
//
//                        //                cell?.Beschrijving1.backgroundColor = UIColor.yellow
//
//                        var image : UIImage = UIImage(named: "hotsun")!
//
//                        cell?.cloudyImage?.image = image
//
//        self.MaanTableView.reloadData()
//
//        }
//
//        action.image = UIImage(named: "cloudy")
//
//        return action
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = self.contextualDeleteAction(forRowAtIndexPath: indexPath)
//         let flagAction = self.contextualToggleFlagAction(forRowAtIndexPath: indexPath)
//        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction, flagAction])
//        return swipeConfig
//    }

//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    {
//        let deleteAction = UIContextualAction(style: .destructive, title: " verwijder") { (action, view, handler) in
//
//
//
//            self.removeAnimalAtIndex(index: indexPath.row)
//            //            // "close" the swipe (1)
//            self.MaanTableView.reloadData()
//            print("Add Action Tapped")
//        }
//
//        deleteAction.backgroundColor = UIColor.orange
//
//        //        deleteAction.image = UIImage(named: "cloudsun")
//
//        let more =
//
//            UIContextualAction(style: .destructive, title: "Add") { (action, view, handler) in
//                print("Stock Picked")
//
//                let cell = self.MaanTableView.cellForRow(at: indexPath) as? MaanTableViewCell
//
//                //                cell?.Beschrijving1.backgroundColor = UIColor.yellow
//
//                var image : UIImage = UIImage(named: "hotsun")!
//
//                cell?.cloudyImage?.image = image
//
//
//        }
//        more.backgroundColor = .yellow
//
//        let less =
//
//            UIContextualAction(style: .destructive, title: "Markeer als betaald") { (action, view, handler) in
//                print("Stock Picked")
//
//                let cell = self.MaanTableView.cellForRow(at: indexPath) as? MaanTableViewCell
//
//                //                cell?.Beschrijving1.backgroundColor = UIColor.yellow
//
//                var image : UIImage = UIImage(named: "cloudy")!
//
//                cell?.cloudyImage?.image = image
//
//
//        }
//        less.backgroundColor = .green
//
//
//        let configuration = UISwipeActionsConfiguration(actions: [more,less,deleteAction])
//        return configuration
//    }




