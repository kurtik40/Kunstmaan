//
//  MaanTableViewCell.swift
//  Kunstmaan
//
//  Created by Kurt Warson on 06/07/2018.
//  Copyright © 2018 Kurt Warson. All rights reserved.
//

import UIKit


class MaanTableViewCell: UITableViewCell  {
    
    
    @IBOutlet weak var cloudyImage: UIImageView!
    
    
    @IBOutlet weak var AchtergrondImage: UIImageView!
    
    @IBOutlet weak var Beschrijving1: UILabel!
    
    
    @IBOutlet weak var Beschrijving2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
