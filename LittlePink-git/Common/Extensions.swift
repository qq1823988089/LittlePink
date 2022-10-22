//
//  Extensions.swift
//  LittlePink-git
//
//  Created by 乔一 on 2022/10/13.
//

import UIKit
import MBProgressHUD

extension UITextField{
    var unwrappedText: String { text ?? "" }
}

extension UIView{
    
    @IBInspectable var radius: CGFloat{
        get{
            layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
    
}

extension UIViewController{
    
    // MARK: 提示框--自动隐藏
    func showTextHUD(_ title: String, _ subtitle: String? = nil){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = title
        hud.detailsLabel.text = subtitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
}

extension Bundle{
    
    var appName: String{
        
        if let appName = Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String{
            return appName
        }else{
            return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
        }
        
    }
    
    //static能修饰class/struct/enum的存储属性、计算属性、方法;class能修饰类的计算属性和方法
    //static修饰的类方法不能继承；class修饰的类方法可以继承
    //在protocol中要使用static
    
    //加载xib上的view
    //为了更通用，使用泛型。as?后需接类型，故形式参数需为T.Type，实质参数为XXView.self--固定用法
    static func loadView<T>(fromNib name: String, with type: T.Type) -> T{
        
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T{
            return view
        }else{
            fatalError("加载\(type)类型的view失败")
        }
        
    }
    
}
