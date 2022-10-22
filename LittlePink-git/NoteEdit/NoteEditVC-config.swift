//
//  NoteEditVC-config.swift
//  LittlePink-git
//
//  Created by 乔一 on 2022/10/19.
//

import Foundation

extension NoteEditVC{
    
    func config(){
        photoCollectionView.dragInteractionEnabled = true
        hideKeyboardWhenTappedAround()
        titleCountLabel.text = "\(kMaxNoteTitleNum)"
        
        let lineFragmentPadding = textView.textContainer.lineFragmentPadding
        //去除textview中文本和placeholder的边距
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -lineFragmentPadding, bottom: 0, right: -lineFragmentPadding)
        //去除textview中文本左右边距
//        textView.textContainer.lineFragmentPadding = 0
        
        //输入文本的行间距设置方法（初识光标有问题）
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let typingAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle : paragraphStyle,
            .font : UIFont.systemFont(ofSize: 14),
            .foregroundColor : UIColor.secondaryLabel
        ]
        textView.typingAttributes = typingAttributes
         
        //光标颜色
        textView.tintColorDidChange()
        //软键盘上面的view
        textView.inputAccessoryView = Bundle.loadView(fromNib: "TextViewIAView", with: TextViewIAView.self)
        textViewIAView.doneBtn.addTarget(self, action: #selector(resignTextView), for: .touchUpInside)
        textViewIAView.maxTextCount.text = "/\(kMaxNoteTextNum)"
        
        // MARK: 请求定位权限
        locationManager.requestWhenInUseAuthorization()
        AMapLocationManager.updatePrivacyShow(AMapPrivacyShowStatus.didShow, privacyInfo: AMapPrivacyInfoStatus.didContain)
        AMapLocationManager.updatePrivacyAgree(AMapPrivacyAgreeStatus.didAgree)
    }
    
}

// MARK: -监听
extension NoteEditVC{
    
    @objc private func resignTextView(){
        textView.resignFirstResponder()
    }
    
}
