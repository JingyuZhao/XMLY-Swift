//
//  FMMineViewController.swift
//  XMLY—Swift
//
//  Created by winbei on 2018/8/31.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit

class FMMineViewController: BaseViewController {

    var testView:UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let animationLayer = CVLayerView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 60))
        animationLayer.center = testView.center
        
        self.view.addSubview(testView)
        testView.addSubview(animationLayer)
        animationLayer .starAnimation()
        testView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60, height: 60))
            make.center.equalToSuperview()
        }
        
    }


}
