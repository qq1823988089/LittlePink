//
//  FollowVC.swift
//  LittlePink-git
//
//  Created by 乔一 on 2022/10/12.
//

import UIKit
import XLPagerTabStrip

class FollowVC: UIViewController, IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: NSLocalizedString("Follow", comment: "关注标签"))
    }

}
