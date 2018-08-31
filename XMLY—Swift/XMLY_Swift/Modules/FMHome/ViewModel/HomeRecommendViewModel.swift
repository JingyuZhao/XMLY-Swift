//
//  HomeRecommendViewModel.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/8/31.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeRecommendViewModel: NSObject {
    //MARK - 数据模型
    var fmhomeRecommendModel:FMHomeRecommendModel?
    var homeRecommendList:[HomeRecommendModel]?
    var recommendList:[RecommendListModel]?
    var focus:[FocusModel]?
    var squareList:[SquareModel]?
    var topBuzzList:[TopBuzzModel]?
    var guessYouLikeList:[GuessYouLikeModel]?
    var paidCategoryList:[PaidCategoryModel]?
    var playList:[PlaylistModel]?
    var oneKeyListenList:[OneKeyListenModel]?
    var liveList:[LiveModel]?
    
    //MARK - 数据源更新
    typealias AddDataBlock = ()->Void
    var updateBlock:AddDataBlock?
    
}
extension HomeRecommendViewModel{
    func refreshDataScoure() ->Void {
        
    }
}
