//
//  WDBottmActionSheet.swift
//  iOS-Swift-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

import UIKit

class WDBottmActionSheet: UIView, UIGestureRecognizerDelegate {

    private var containerView : UIView?
    private let Sheet_ScreenHeight = UIScreen.main.bounds.size.height
    private let Sheet_ScreenWidth = UIScreen.main.bounds.size.width
    private var delegate : WDActionSheetDelegate?
    
    // MARK: -  初始化
    convenience init(titleArray : Array<String> ,cancelButtonTitle : String , delegate : WDActionSheetDelegate) {
        self.init()
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(dismissView))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        if titleArray.count == 0 {
            fatalError("标题数组不能为空")
        } else {
            setupUI(titleArray: titleArray, cancelButtonTitle: cancelButtonTitle, delegate: delegate)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: -  绘制页面
    private func setupUI(titleArray : Array<String> ,cancelButtonTitle : String , delegate : WDActionSheetDelegate) {
        containerView = UIView.init()
        containerView?.backgroundColor = UIColor.lightGray
        let W:CGFloat = Sheet_ScreenWidth
        let X:CGFloat = 0
        let H:CGFloat = 55
        let Speace:CGFloat = 15
        
        if cancelButtonTitle.count == 0 {
            for (index, _) in titleArray.enumerated() {
                let button = setupButtons(title: titleArray[index], buttonTag: 10+index)
                containerView?.addSubview(button)
                button.frame = CGRect(x: X, y: H * CGFloat(index), width: W, height: H)
                if index == titleArray.count - 1 {
                    let line = setupLineView()
                    containerView?.addSubview(line)
                    line.frame = CGRect(x: X, y: H * CGFloat(index) + 0.5, width: W, height: 0.5)
                }
            }
            
        } else {
            
            for (index, _) in titleArray.enumerated() {
                let button = setupButtons(title: titleArray[index], buttonTag: 10+index)
                containerView?.addSubview(button)
                button.frame = CGRect(x: X, y: H * CGFloat(index), width: W, height: H)
                
                if index > 0 {
                    let line = setupLineView()
                    containerView?.addSubview(line)
                    line.frame = CGRect(x: X, y: H * CGFloat(index) + 0.5, width: W, height: 0.5)
                }
            }
            
            let cancalButton = setupButtons(title: cancelButtonTitle, buttonTag: 9)
            containerView?.addSubview(cancalButton)
            cancalButton.frame = CGRect(x: X, y: (H + 0.5) * CGFloat(titleArray.count) + Speace, width: W, height: H)
        }
        
        self.delegate = delegate
        
        var AllHeight:CGFloat = 0.0
        
        if cancelButtonTitle.count > 0 {
            AllHeight = H * CGFloat(titleArray.count + 1) + 15.0
        } else {
            AllHeight = H * CGFloat(titleArray.count)
        }
        
        showView(height: AllHeight)
    }
    
    
    // MARK: -  公共创建按钮
    private func setupButtons(title : String, buttonTag : Int) -> UIButton {
        let button = UIButton.init(type: .custom)
        button.sizeToFit()
        button.backgroundColor = UIColor.white
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tag = buttonTag
        button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        
        return button
    }
    
    
    // MARK: -  公共创建线条
    private func setupLineView() -> UIView {
        let line = UIView.init()
        line.backgroundColor = UIColor.lightGray
        return line
    }
    
    
    // MARK: -  点击事件并传值
    @objc private func buttonAction(sender : UIButton) {
        if sender.tag != 9 {
            delegate?.selectedIndex(index: sender.tag)
        }
        
        dismissView()
    }
    
    // MARK: -  页面显示
    private func showView(height:CGFloat) {
        
        UIApplication.shared.keyWindow?.addSubview(self)
        addSubview(containerView!)
        
        frame = UIScreen.main.bounds;
        containerView?.frame = CGRect(x: 0, y: Sheet_ScreenHeight, width: Sheet_ScreenWidth, height: 0)
        
        UIView.animateKeyframes(withDuration: 0.35, delay: 0, options: .calculationModeLinear, animations: {
            self.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
            self.containerView?.frame = CGRect(x: 0, y: self.Sheet_ScreenHeight-height, width: self.Sheet_ScreenWidth, height: height)
        }, completion: nil)
    }
    
    
    // MARK: - 页面消失
    @objc private func dismissView() {
        
        UIView.animateKeyframes(withDuration: 0.35, delay: 0, options: .calculationModeLinear, animations: {
            self.backgroundColor = UIColor.init(white: 0, alpha: 0.0)
            self.containerView?.frame = CGRect(x: 0, y: self.Sheet_ScreenHeight, width: self.Sheet_ScreenWidth, height: 0)
            
        }) { (finished) in
            self.removeFromSuperview()
            self.containerView?.removeFromSuperview()
        }
    }
}

// MARK: -  代理
@objc protocol WDActionSheetDelegate{
    func selectedIndex(index:Int) -> Void
}

