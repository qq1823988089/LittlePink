//
//  NearbyVC.swift
//  LittlePink-git
//
//  Created by 乔一 on 2022/10/12.
//

import UIKit
import XLPagerTabStrip

class NearbyVC: UIViewController, IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: NSLocalizedString("Nearby", comment: "附近标签"))
    }

}
