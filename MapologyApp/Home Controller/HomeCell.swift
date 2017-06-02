//
//  HomeCell.swift
//  MapologyApp
//
//  Created by 34in on 27/03/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet var bg_view: UIView!

    @IBOutlet var follow: UIButton!
    @IBOutlet var img: UIImageView!
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var describe: UILabel!
  
    
    @IBOutlet var type: UILabel!
    @IBOutlet var distance: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
