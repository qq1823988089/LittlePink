//
//  TextViewIAView.swift
//  LittlePink-git
//
//  Created by 乔一 on 2022/10/19.
//

import UIKit

class TextViewIAView: UIView {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var textCountStackView: UIStackView!
    @IBOutlet weak var currentTextCount: UILabel!
    @IBOutlet weak var maxTextCount: UILabel!
    
    var currentTextNum = 0{
        didSet{
            if currentTextNum < kMaxNoteTextNum{
                doneBtn.isHidden = false
                textCountStackView.isHidden = true
            }else{
                doneBtn.isHidden = true
                textCountStackView.isHidden = false
                currentTextCount.text = "\(currentTextNum)"
            }
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
