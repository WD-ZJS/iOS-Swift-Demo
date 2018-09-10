//
//  WDSegemenView.swift
//  iOS-Swift-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

import UIKit
@objc public protocol WDSegemenViewDataSource:NSObjectProtocol {
    
    /// 获取标题数组
    ///
    /// - Returns: 数组
    func titleArrayOfSegmentView() -> Array<String>
    
    /// 获取控制器数组
    ///
    /// - Returns: 数组
    func controllerOfSegementView() -> Array<UIViewController>
}

@objc public protocol WDSegemenViewDelegate:NSObjectProtocol {
    func segmentViewClickAtIndex(index:Int) ->Void
}

enum WDSegementStyle {
    case WDSegementStyleDefualt
    case WDSegementStyleBottomLine
}

class WDSegemenView: UIView, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    weak var delegete:WDSegemenViewDelegate?
    weak var dataSource:WDSegemenViewDataSource? {
        didSet {
            if self.dataSource != nil && (self.dataSource?.responds(to: #selector(WDSegemenViewDataSource.titleArrayOfSegmentView)))! {
                titleArray = self.dataSource?.titleArrayOfSegmentView()
            } else {
                print("标题数量不能为0")
                titleArray = nil
                return
            }

            if self.dataSource != nil && (self.dataSource?.responds(to: #selector(WDSegemenViewDataSource.controllerOfSegementView)))! {
                controllerArray = self.dataSource?.controllerOfSegementView()
            } else {
                print("控制器数量不能为0")
                controllerArray = nil
                return
            }
            
            if titleArray?.count != controllerArray?.count {
                print("控制器数量和标题数量不一致")
                return
            }
        }
    }
    
    
    /// 当前选中的Item的下标
    private var selectedIndex:Int = 0
    /// 标题数组
    private var titleArray:Array<String>?
    /// 控制器数组
    private var controllerArray:Array<UIViewController>?
    
    private lazy var scrollView:UIScrollView = {
       let sr = UIScrollView.init()
        sr.showsVerticalScrollIndicator = false
        sr.showsHorizontalScrollIndicator = false
        sr.isPagingEnabled = true
        return sr
    }()

    
    /// 底部controller的容器
    private lazy var pageController:UIPageViewController = {
        let pageController =  UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionInterPageSpacingKey:10])
        pageController.delegate = self
        pageController.dataSource = self
        return pageController
    }()
    
    /// 底部分割线
    private lazy var bottomLine:UIView = {
       let view = UIView.init()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    private lazy var indicator:UIView = {
       let view = UIView.init()
        view.backgroundColor = UIColor.orange
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviewsProperties()
        setupSubViewConstraints()
    }
    
    private func setupSubviewsProperties() {
        addSubview(pageController.view)
        addSubview(scrollView)
        addSubview(bottomLine)
        addSubview(indicator)
        bringSubview(toFront: indicator)
    }

    private func setupSubViewConstraints() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let header_top = NSLayoutConstraint.init(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let header_leading = NSLayoutConstraint.init(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15)
        let header_trealing = NSLayoutConstraint.init(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15)
        let header_height = NSLayoutConstraint.init(item: scrollView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 45)
        addConstraints([header_top, header_trealing, header_leading, header_height])
        
        
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        let page_top = NSLayoutConstraint.init(item: pageController.view, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0)
        let page_leading = NSLayoutConstraint.init(item: pageController.view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let page_trealing = NSLayoutConstraint.init(item: pageController.view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let page_height = NSLayoutConstraint.init(item: pageController.view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        addConstraints([page_top, page_leading, page_trealing, page_height])
        
        
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        let line_top = NSLayoutConstraint.init(item: bottomLine, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: -1)
        let line_leading = NSLayoutConstraint.init(item: bottomLine, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let line_trealing = NSLayoutConstraint.init(item: bottomLine, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let line_height = NSLayoutConstraint.init(item: bottomLine, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant:0.5)
        addConstraints([line_top, line_leading, line_trealing, line_height])
    }
    
    private var speace:CGFloat = 10
    
    private var buttonArray:Array<CGFloat>?
    
    private var selectedButton:UIButton?
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        scrollView.layoutIfNeeded()
        
        var x:CGFloat = 10.0
        
        for (index, string) in (titleArray?.enumerated())! {
            let b = UIButton.init(type: .custom)
            b.setTitle(string, for: .normal)
            b.setTitleColor(UIColor.lightGray, for: .normal)
            b.setTitleColor(UIColor.orange, for: .selected)
            b.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            b.tag = 10 + index
            b.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            scrollView.addSubview(b)
            let size:CGSize = (string as NSString).size(withAttributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)])
            b.frame = CGRect(x: x, y: 0, width:size.width , height: scrollView.frame.height)
            x += size.width + speace
            if index == 0 {
                showChildViewController(at: 0)
            }
        }

        scrollView.contentSize = CGSize(width: x, height: 0)
    }
    
    
    @objc func buttonAction(sender:UIButton) {
        showChildViewController(at: sender.tag-10)
    }
    
    //MARK:-计算按钮间距
    fileprivate func calculateButtonMargin() {
        guard let arrTitle = titleArray else {return}
        var widthTotal:CGFloat = 0
        for (_,title) in arrTitle.enumerated() {
            let width = (title as NSString).size(withAttributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)]).width
            widthTotal += width
        }
        
        if (widthTotal+CGFloat(arrTitle.count)*speace) > self.scrollView.frame.width {

            
        } else {
            speace = (self.scrollView.frame.width-widthTotal)/CGFloat(arrTitle.count)
        }
    }
    
    /// 根据index显示控制器
    ///
    /// - Parameter index: 下标
    private func showChildViewController(at index: Int) {
        
        if index >= controllerArray!.count || index < 0 {
            return
        }
        
        let button:UIButton = self.viewWithTag(index + 10) as! UIButton
        button.isSelected = true
        selectedButton?.isSelected = !(selectedButton?.isSelected)!
        selectedButton = button
        
        if (delegete != nil) && (delegete?.responds(to: #selector(WDSegemenViewDelegate.segmentViewClickAtIndex(index:))))! {
            delegete?.segmentViewClickAtIndex(index: index)
        }

        var currentIndex = 0
        if let currentVC = pageController.viewControllers?.last,
            let idx = controllerArray!.index(of: currentVC) {
            currentIndex = idx
        }
        let toVC = controllerArray![index]
        let direction: UIPageViewControllerNavigationDirection = (currentIndex > index) ? .reverse : .forward
        pageController.setViewControllers([toVC], direction: direction, animated: true, completion: nil)
        

        let btnCenterX:CGFloat = (selectedButton?.center.x)!
        let topScrollWidth:CGFloat = scrollView.frame.width
        let topScrollConsizeWidth = scrollView.contentSize.width
        
        if btnCenterX < topScrollWidth/2 {
            scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        } else if btnCenterX + topScrollWidth/2 < topScrollConsizeWidth {
            scrollView.setContentOffset(CGPoint.init(x: btnCenterX-topScrollWidth/2, y: 0), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint.init(x: topScrollConsizeWidth-topScrollWidth, y: 0), animated: true)
        }
        
        UIView.animate(withDuration: 0.3) {
           
        }
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ============ UIPageViewControllerDataSource ============
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if controllerArray!.count == 0 { return nil }
        guard
            let index = controllerArray!.index(of: viewController)
            else { return nil }
        if index > 0 {
            return controllerArray![index-1]
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if controllerArray!.count == 0 { return nil }
        guard
            let index = controllerArray!.index(of: viewController)
            else { return nil }
        if index < controllerArray!.count - 1 {
            return controllerArray![index+1]
        }
        return nil
    }
    
    // MARK: ============ UIPageViewControllerDelegate ============
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard
            let currentVC = pageViewController.viewControllers?.last,
            let index = controllerArray!.index(of: currentVC)
            else { return }
        if completed {
            showChildViewController(at: index)
        }
    }
}

