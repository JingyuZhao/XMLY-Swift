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
    var focus:FocusModel?
    var squareList:[SquareModel]?
    var topBuzzList:[TopBuzzModel]?
    var guessYouLikeList:[GuessYouLikeModel]?
    var paidCategoryList:[PaidCategoryModel]?
    var playList:PlaylistModel?
    var oneKeyListenList:[OneKeyListenModel]?
    var liveList:[LiveModel]?
    
    //MARK - 数据源更新
    typealias AddDataBlock = ()->Void
    var updateBlock:AddDataBlock?
    
}
extension HomeRecommendViewModel{
    func refreshDataScoure() ->Void {
        FMRecommendProvider.request(FMRecommendApi.recommendList, completion: {result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                if let mappedObject = JSONDeserializer<FMHomeRecommendModel>.deserializeFrom(json: json.description){
                    
                    self.fmhomeRecommendModel = mappedObject;
                    self.homeRecommendList = mappedObject.list
                    
                    if let recommendList = JSONDeserializer<RecommendListModel>.deserializeModelArrayFrom(json: json["list"].description){
                        self.recommendList = recommendList as? [RecommendListModel]
                    }
                    
                    if let focus = JSONDeserializer<FocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description){
                        self.focus = focus
                    }
                    
                    if let square = JSONDeserializer<SquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description){
                        self.squareList = square as? [SquareModel]
                    }
                    if let topBuzz = JSONDeserializer<TopBuzzModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description) {
                        self.topBuzzList = topBuzz as? [TopBuzzModel]
                    }
                    
                    if let oneKeyListen = JSONDeserializer<OneKeyListenModel>.deserializeModelArrayFrom(json: json["list"][9]["list"].description) {
                        self.oneKeyListenList = oneKeyListen as? [OneKeyListenModel]
                    }
                    
                    if let live = JSONDeserializer<LiveModel>.deserializeModelArrayFrom(json: json["list"][14]["list"].description) {
                        self.liveList = live as? [LiveModel]
                    }
                    self.updateBlock?()
                    
                }
                
            }
        });
    }
}
