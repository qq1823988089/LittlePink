//
//  NoteEditVC.swift
//  LittlePink-git
//
//  Created by 乔一 on 2022/10/15.
//

import UIKit


class NoteEditVC: UIViewController {

    var photos = [
        UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!
    ]
    var videoURL: URL?
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelPlaceholderLabel: UILabel!
    
    //如果photos.count没变就不会重复计算
    var photoCount: Int{ photos.count }
    var isVideo: Bool{
        videoURL != nil
    }
    var textViewIAView: TextViewIAView{ textView.inputAccessoryView as! TextViewIAView }
    
    var channel = ""
    var subChannel = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        config()
        
    }
    

    @IBAction func TFEditBegin(_ sender: Any) {
        titleCountLabel.isHidden = false
    }
    
    @IBAction func TFEditEnd(_ sender: Any) {
        titleCountLabel.isHidden = true
    }
    
    //轻触return收起软键盘
    @IBAction func TFEndOnExit(_ sender: Any) {
    }
    
    @IBAction func TFEditChanged(_ sender: Any) {
        guard titleTextField.markedTextRange == nil else { return }
        if titleTextField.unwrappedText.count > kMaxNoteTitleNum{
            titleTextField.text = String(titleTextField.unwrappedText.prefix(kMaxNoteTitleNum))
            showTextHUD("标题最多输入\(kMaxNoteTitleNum)个字")
            
            DispatchQueue.main.async {
                let end = self.titleTextField.endOfDocument
                self.titleTextField.selectedTextRange = self.titleTextField.textRange(from: end, to: end)
            }
            
        }
        titleCountLabel.text = "\(kMaxNoteTitleNum - titleTextField.unwrappedText.count)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let channelVC = segue.destination as? ChannelVC{
            channelVC.PVDelegate = self
        }
        
    }
    

}

extension NoteEditVC: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        guard textView.markedTextRange == nil else { return }
        textViewIAView.currentTextNum = textView.text.count
    }
}

extension NoteEditVC: ChannelVCDelegate{
    
    func updateChannel(channel: String, subChannel: String) {
        //数据
        self.channel = channel
        self.subChannel = subChannel
        //UI
        channelIcon.tintColor = blueColor
        channelLabel.text = subChannel
        channelLabel.textColor = blueColor
        channelPlaceholderLabel.isHidden = true
    }
    
}
/*
 extension NoteEditVC: UITextFieldDelegate{
 
 //轻触return收起软键盘
 //   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 //        textField.resignFirstResponder()
 //        return true
 //    }
 
 func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 //不能用titleTextField.unwrappedText.count，因为在输入之前就会拦截输入法中的任何输入，导致不能删除，而range.location可以得到即将输入字符的索引位置
 let isExceed = range.location >= kMaxNoteTitleNum || (textField.unwrappedText.count + string.count) > kMaxNoteTitleNum
 if isExceed {
 showTextHUD("标题最多输入\(kMaxNoteTitleNum)个字")
 return false
 }else{
 return true
 }
 //return !isExceed
 }
 
 }
 */
