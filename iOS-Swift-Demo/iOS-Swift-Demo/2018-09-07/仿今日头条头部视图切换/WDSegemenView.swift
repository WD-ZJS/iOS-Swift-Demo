//
//  WDSegemenView.swift
//  iOS-Swift-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

import UIKit

@objc
public protocol WDSegemenViewDataSource:NSObjectProtocol {
    
    func titleArrayOfSegmentView() -> Array<String>
    
    func controllerOfSegementView() -> Array<UIViewController>
}

@objc
public protocol WDSegemenViewDelegate:NSObjectProtocol {
    func segmentViewClickAtIndex(index:Int) ->Void
}

class WDSegemenView: UIView {
   
    weak var dataSource:WDSegemenViewDataSource? {
        didSet {
            if self.dataSource != nil && (self.dataSource?.responds(to: #selector(WDSegemenViewDataSource.titleArrayOfSegmentView)))! {
                titleArray = self.dataSource?.titleArrayOfSegmentView()
            } else {
                titleArray = nil
            }
            
            if self.dataSource != nil && (self.dataSource?.responds(to: #selector(WDSegemenViewDataSource.controllerOfSegementView)))! {
                controllerArray = self.dataSource?.controllerOfSegementView()
            } else {
                controllerArray = nil
            }
            
            if titleArray?.count != controllerArray?.count {
                print("控制器数量和标题数量不一致")
                return
            }
        }
    }
    
    private var titleArray:Array<String>?
    private var controllerArray:Array<UIViewController>?

    public var delegete:WDSegemenViewDelegate?
    
    
    private lazy var collectionLayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout.init()
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width/6, height: 45)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        return layout
    }()

    private lazy var headerCollectionView:UIScrollView = {
        let scrollView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        scrollView.backgroundColor = UIColor.white
        scrollView.dataSource = self
        scrollView.delegate = self
        scrollView.register(WDSegmentHeaderCell.classForCoder(), forCellWithReuseIdentifier: "WDSegmentHeaderCell")
        return scrollView
    }()
    
    private lazy var pageController:UIPageViewController = {
        let pageController =  UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionInterPageSpacingKey:10])
        pageController.delegate = self as? UIPageViewControllerDelegate
        pageController.dataSource = self as? UIPageViewControllerDataSource
        return pageController
    }()
    
    private lazy var indicatorView:UIView = {
        let view = UIView.init()
        /// 默认颜色
        view.backgroundColor = UIColor.orange
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
              
        self.addSubview(pageController.view)
        self.addSubview(headerCollectionView);
        headerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let header_top = NSLayoutConstraint.init(item: headerCollectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let header_leading = NSLayoutConstraint.init(item: headerCollectionView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let header_trealing = NSLayoutConstraint.init(item: headerCollectionView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let header_height = NSLayoutConstraint.init(item: headerCollectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 45)
        self.addConstraints([header_top, header_trealing, header_leading, header_height])
        
        headerCollectionView.addSubview(indicatorView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - UIPageViewControllerDataSource
extension WDSegemenViewController:UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}


// MARK: - UIPageViewControllerDelegate
extension WDSegemenViewController:UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    }
}


// MARK: - UICollectionViewDataSource
extension WDSegemenView:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:WDSegmentHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WDSegmentHeaderCell", for: indexPath) as! WDSegmentHeaderCell
        cell.titleLabel.text = "今日头条"
        return cell
    }
}


// MARK: - UICollectionViewDelegate
extension WDSegemenView:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

private class WDSegmentHeaderCell: UICollectionViewCell {
    
    lazy var titleLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint.init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        let trealing = NSLayoutConstraint.init(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint.init(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem:contentView , attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraints([top, leading, trealing, bottom])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes:UICollectionViewLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        let size:CGSize = getNormalStrSize(str: self.titleLabel.text, attriStr: nil, font: 15, w: self.frame.width, h: self.frame.height)
        var rect = CGRect.zero
        rect.size = size
        rect.size.width += 8
        rect.size.height += 8
        attributes.frame = rect
        return attributes
    }
    
    /**获取字符串尺寸--私有方法*/
    private func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
        if str != nil {
            let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: font)], context: nil).size
            return strSize
        }
        
        if attriStr != nil {
            let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }
        return CGSize.zero
    }
}
