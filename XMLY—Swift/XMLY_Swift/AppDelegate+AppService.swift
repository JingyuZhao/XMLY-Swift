//
//  AppDelegate+AppService.swift
//  XMLY—Swift
//
//  Created by winbei on 2018/8/31.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import Foundation
import UIKit
import ESTabBarController_swift

extension AppDelegate {
    
    //设置根视图
    func initWindow() -> Void {
    
        self.window = UIWindow.init(frame: UIScreen.main.bounds);
        let tab = self.setTabBarStyle(delegate: self as? UITabBarControllerDelegate)
        self.window?.rootViewController = tab;
        self.window?.makeKeyAndVisible();
        
        setStaticGuidePage()
//        setDynamicGuidePage()
//        setVideoGuidePage()
    }
    

    //设置tabbar
    func setTabBarStyle(delegate:UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarController = ESTabBarController();
        tabBarController.delegate = delegate;
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent");
        tabBarController.shouldHijackHandler = {
          tabbarController, viewController, index in
            if index==2 {
                return true;
            }
            return false;
        };
        
        tabBarController.didHijackHandler = {
           [weak tabBarController] tabbarController, viewController, index in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
               
                
            });
        };
        
        let VC1 = FMHomeViewController()
        let VC2 = FMListenViewController()
        let VC3 = FMPlayerViewController()
        let VC4 = FMFindViewController()
        let VC5 = FMMineViewController()
        
        VC1.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        VC2.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "我听", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        VC3.tabBarItem = ESTabBarItem.init(YYIrregularityContentView(), title: nil, image: UIImage(named: "tab_play"), selectedImage: UIImage(named: "tab_play"))
        VC4.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "发现", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        VC5.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "我的", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        
        let Nav1 = BaseNavigationController.init(rootViewController: VC1);
        let Nav2 = BaseNavigationController.init(rootViewController: VC2);
        let Nav3 = BaseNavigationController.init(rootViewController: VC3);
        let Nav4 = BaseNavigationController.init(rootViewController: VC4);
        let Nav5 = BaseNavigationController.init(rootViewController: VC5);
        
        VC1.navigationItem.title = "首页"
        VC2.navigationItem.title = "我听"
        VC3.navigationItem.title = "播放"
        VC4.navigationItem.title = "发现"
        VC5.navigationItem.title = "我的"
        
        tabBarController.viewControllers = [Nav1,Nav2,Nav3,Nav4,Nav5];
        return tabBarController;
    }
    
    func setStaticGuidePage() {
        let imageNameArray : [String] = ["lead01", "lead02", "lead03"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false);
        self.window?.rootViewController?.view.addSubview(guideView)
    }
    
    func setDynamicGuidePage() {
        let imageNameArray: [String] = ["guideImage6.gif", "guideImage7.gif", "guideImage8.gif"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        self.window?.rootViewController?.view.addSubview(guideView)
    }
    
    func setVideoGuidePage() {
        let urlStr = Bundle.main.path(forResource: "qidong.mp4", ofType: nil)
        let videoUrl = NSURL.fileURL(withPath: urlStr!)
        let guideView = HHGuidePageHUD.init(videoURL: videoUrl, isHiddenSkipButton: false)
        self.window?.rootViewController?.view.addSubview(guideView)
    }
}
