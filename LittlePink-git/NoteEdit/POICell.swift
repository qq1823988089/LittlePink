//
//  POICell.swift
//  LittlePink-git
//
//  Created by 乔一 on 2022/10/22.
//

import UIKit

class POICell: UITableViewCell {

    @IBOutlet weak var POILabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    
    var POI = ["", ""]{
        didSet{
            POILabel.text = POI[0]
            AddressLabel.text = POI[1]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
