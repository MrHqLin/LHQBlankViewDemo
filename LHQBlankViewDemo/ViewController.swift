//
//  ViewController.swift
//  LHQBlankViewDemo
//
//  Created by WaterWorld on 2019/3/22.
//  Copyright © 2019年 linhuaqin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        for i in 0..<3 {
            let button = UIButton.init()
            button.setTitle("show\(i)", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.frame = CGRect(x: 100, y: 80 + i * 60, width: 80, height: 40)
            button.tag = i
            button.addTarget(self, action: #selector(tap(sender:)), for: .touchUpInside)
            self.view.addSubview(button)
        }
    }
    
    @objc func tap(sender: UIButton) -> Void {
        switch sender.tag {
        case 0:
            self.view.configEasyBlankPageView(type: .noNetwork, hasData: true, reload: nil)
        case 1:
            self.view.configEasyBlankPageView(type: .noNetwork, hasData: false) {
                print("nodata")
            }
        case 2:
            self.view.configEasyBlankPageView(type: .loading, hasData: false, reload: nil)
        case 3:
            self.view.configEasyBlankPageView(type: .error, hasData: false) {
                print("error")
            }
        default: break
            
        }
    }


}

