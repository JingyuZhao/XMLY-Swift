//
//  FMHomeViewController.swift
//  XMLY—Swift
//
//  Created by winbei on 2018/8/31.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit
import DNSPageView

class FMHomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let style = DNSPageStyle()
        style.isTitleScrollEnable = false
        style.isScaleEnable = true
        style.isShowBottomLine = true
        style.titleSelectedColor = .black
        style.titleColor = .gray
        style.bottomLineColor = FMDominant_Color;
        style.bottomLineHeight = 2
        
        let titles = ["推荐","分类","VIP","直播","广播"]
        let viewControllers:[BaseViewController] = [HomeReCommendViewController(),HomeClassifyViewController(),HomeVipViewController(),HomeLiveViewController(),HomeBroadcastViewController()]
        for vc in viewControllers {
            self.addChildViewController(vc)
        }
        let pageViewHeight = FMScreenHeigth - FMTopHeight - 40;
        let pageView = DNSPageView.init(frame: CGRect(x: 0, y: FMTopHeight, width: FMScreenWidth, height: pageViewHeight), style: style, titles: titles, childViewControllers: viewControllers)
        
        view.addSubview(pageView)
        
        
    }

}
