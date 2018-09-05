//
//  FMListenViewController.swift
//  XMLY—Swift
//
//  Created by winbei on 2018/8/31.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit
import LTScrollView
class FMListenViewController: BaseViewController {

    private let headerView = FMListenHeaderView.init(frame: CGRect(x:0, y:0, width:FMScreenWidth, height:120))
    private let viewControllers:[BaseViewController] = {
        return [ListenOneViewController(),ListenTwoViewController(),ListenThreeViewController()]
    }()
    private let titles:[String] = ["订阅", "一键听", "推荐"]
    
    private let layout:LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
        layout.bottomLineColor = UIColor.red
        layout.sliderHeight = 60
        
        return layout
    }()
    
    private lazy var advancedManager: LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: FMTopHeight, width: FMScreenWidth, height: FMScreenHeigth-FMTopHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: {[weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        /* 设置悬停位置 */
        //        advancedManager.hoverY = -navigationBarHeight
        /* 点击切换滚动过程动画 */
        //        advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        //        advancedManager.scrollToIndex(index: viewControllers.count - 1)
        return advancedManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfig()
    }

}
extension FMListenViewController:LTAdvancedScrollViewDelegate{
    //MARK: 具体使用请参考以下
    private func advancedManagerConfig() {
        //MARK: 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        //        print("offset --> ", offsetY)
    }
}
