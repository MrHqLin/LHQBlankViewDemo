//
//  EasyBlankPageView.swift
//  LHQSwiftDemo
//
//  Created by WaterWorld on 2019/3/22.
//  Copyright © 2019年 linhuaqin. All rights reserved.
//

import UIKit

enum EasyBlankPageViewType {
    case noNetwork
    case noData
    case error
    case loading
}

typealias reloadBlock = () -> Void

class EasyBlankPageView: UIView {
    
    var imageView: UIImageView?
    var tipLabel: UILabel?
    var reloadBtn: UIButton?
    var activityView: UIActivityIndicatorView?
    
    var reloadBlock: reloadBlock?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    
    func setupUI() -> Void {
        self.backgroundColor = UIColor.white
        
        self.imageView = UIImageView.init(image: UIImage.init(named: "common_noNetWork"))
        self.addSubview(self.imageView!)
        
        self.tipLabel = UILabel.init()
        self.tipLabel?.text = "test tip"
        self.tipLabel?.font = UIFont.systemFont(ofSize: 16)
        self.tipLabel?.textColor = UIColor.black
        self.tipLabel?.textAlignment = .center
        self.tipLabel?.numberOfLines = 0
        self.addSubview(self.tipLabel!)
        
        self.reloadBtn = UIButton.init()
        self.reloadBtn?.setTitle("点击重新加载", for: .normal)
        self.reloadBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.reloadBtn?.setTitleColor(UIColor.black, for: .normal)
        self.reloadBtn?.layer.borderColor = UIColor.black.cgColor
        self.reloadBtn?.layer.borderWidth = 1
        self.reloadBtn?.addTarget(self, action: #selector(reloadTap), for: .touchUpInside)
        self.addSubview(self.reloadBtn!)
        
        self.activityView = UIActivityIndicatorView.init(style: .white)
        self.activityView?.color = UIColor.black
        self.addSubview(self.activityView!)
        
        
        self.imageView?.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.imageView?.center = self.center
        
        self.tipLabel?.frame = CGRect(x: 5, y: (self.imageView?.frame)!.maxY, width: UIScreen.main.bounds.size.width - 10, height: 40)
        
        self.reloadBtn?.frame = CGRect(x: 5, y: (self.tipLabel?.frame)!.maxY, width: UIScreen.main.bounds.size.width - 10, height: 40)
        
//        self.imageView?.mas_makeConstraints({ (make) in
//            make?.centerX.equalTo()(self.mas_centerX)
//            make?.centerY.equalTo()(self.mas_centerY)
//        })
//
//        self.tipLabel?.mas_makeConstraints({ (make) in
//            make?.top.equalTo()(self.imageView?.mas_bottom)
//            make?.centerX.equalTo()(self.imageView?.mas_centerX)
//        })
//
//        self.reloadBtn?.mas_makeConstraints({ (make) in
//            make?.top.equalTo()(self.tipLabel?.mas_bottom)?.offset()(10~)
//            make?.centerX.equalTo()(self.tipLabel?.mas_centerX)
//            make?.size.equalTo()(CGSize(width: 100~, height: 40~))
//        })
//
//        self.activityView?.mas_makeConstraints({ (make) in
//            make?.centerY.equalTo()(self.mas_centerY)
//            make?.centerX.equalTo()(self.mas_centerX)
//        })
        
    }
    
    func configEaseBlankPageView(type: EasyBlankPageViewType, hasData: Bool, reload:reloadBlock?) -> Void {
        if hasData {
            self.removeFromSuperview()
            return
        }
        self.imageView?.isHidden = false
        self.tipLabel?.isHidden = false
        self.reloadBtn?.isHidden = false
        self.activityView?.stopAnimating()
        self.reloadBlock = reload
        switch type {
        case .noNetwork:
            self.imageView?.image = UIImage.init(named: "common_noNetWork")
            self.tipLabel?.text = "网络未连接"
            self.activityView?.stopAnimating()
        case .noData:
            self.imageView?.image = UIImage.init(named: "common_noData")
            self.tipLabel?.text = "暂无数据"
            self.activityView?.stopAnimating()
        case .error:
            self.imageView?.image = UIImage.init(named: "common_noData")
            self.tipLabel?.text = "出错了"
            self.activityView?.stopAnimating()
        case .loading:
            self.imageView?.isHidden = true
            self.tipLabel?.isHidden = true
            self.reloadBtn?.isHidden = true
            self.activityView?.startAnimating()
        }
        
        
    }
    
    @objc func reloadTap() -> Void {
        self.reloadBlock?()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private var BlankPageViewKey: String = "BlankPageViewKey"
extension UIView{
    
    var blankPageView: EasyBlankPageView?{
        get {
            return (objc_getAssociatedObject(self, &BlankPageViewKey) as? EasyBlankPageView)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &BlankPageViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    func configEasyBlankPageView(type: EasyBlankPageViewType, hasData: Bool, reload:reloadBlock?) -> Void {
        if (self.blankPageView != nil) {
            self.blankPageView?.isHidden = true
            self.blankPageView?.removeFromSuperview()
        }
        if hasData == false {
            self.blankPageView = EasyBlankPageView.init(frame: self.bounds)
            self.blankPageView?.configEaseBlankPageView(type: type, hasData: hasData, reload: reload)
            self.addSubview(self.blankPageView!)
        }
    }
    
    func removcEasyBlankView() -> Void {
        self.blankPageView?.removeFromSuperview()
    }
    
}
