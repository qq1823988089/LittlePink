//
//  PhotoFooter.swift
//  LittlePink-git
//
//  Created by 乔一 on 2022/10/16.
//

import UIKit

class PhotoFooter: UICollectionReusableView {
        
    @IBOutlet weak var addPhotoBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addPhotoBtn.layer.borderWidth = 1
        addPhotoBtn.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
}
