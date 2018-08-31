//
//  BaseNavigationController.swift
//  XMLY—Swift
//
//  Created by winbei on 2018/8/31.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarApprence();
        // Do any additional setup after loading the view.
    }
}

func setNavBarApprence(){
    WRNavigationBar.defaultNavBarTintColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1);
    WRNavigationBar.defaultNavBarTintColor = FMNavBarTin_Color!;
    WRNavigationBar.defaultNavBarTitleColor = .black;
    WRNavigationBar.defaultShadowImageHidden = true
    
}
extension BaseNavigationController{
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
