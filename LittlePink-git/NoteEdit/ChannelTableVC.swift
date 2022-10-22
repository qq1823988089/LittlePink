//
//  ChannelTableVC.swift
//  LittlePink-git
//
//  Created by 乔一 on 2022/10/21.
//

import UIKit
import XLPagerTabStrip

class ChannelTableVC: UITableViewController {
    
    var channel = ""
    var subChannels: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subChannels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSubChannelCellID, for: indexPath)

        cell.textLabel?.text = "# \(subChannels[indexPath.row])"
        cell.textLabel?.font = .systemFont(ofSize: 15)

        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let channelVC = parent as! ChannelVC
        channelVC.PVDelegate?.updateChannel(channel: channel, subChannel: subChannels[indexPath.row])
        
        //子视图控制器的presentingViewController和父视图控制器一样（这里为NoteEditVC）
        //故这里用dimiss就等于是在父视图控制器中直接用dismiss
        dismiss(animated: true)
    }
    


}

extension ChannelTableVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        IndicatorInfo(title: channel)
    }
    
}
