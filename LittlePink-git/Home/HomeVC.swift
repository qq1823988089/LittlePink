//
//  HomeVC.swift
//  LittlePink-git
//
//  Created by 乔一 on 2022/10/10.
//

import UIKit
import XLPagerTabStrip

class HomeVC: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        
        // MARK: 设置最上方bar
        settings.style.selectedBarBackgroundColor = UIColor.systemPink
        settings.style.selectedBarHeight = 3
        
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarItemTitleColor = .label
        settings.style.buttonBarItemFont = .systemFont(ofSize: 16)
        
        super.viewDidLoad()

        containerView.bounces = false
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label
        }
        
        
    }
    

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let followVC = storyboard!.instantiateViewController(withIdentifier: kFollowVCID)
        let nearbyVC = storyboard!.instantiateViewController(withIdentifier: kNearbyVCID)
        let discoveryVC = storyboard!.instantiateViewController(withIdentifier: kDiscoveryVCID)
        
        return [discoveryVC, followVC, nearbyVC]
    }

}
