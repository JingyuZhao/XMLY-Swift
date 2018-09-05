//
//  HomeClassifyViewModel.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/9/4.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeClassifyViewModel: NSObject {
    var classifyModel:[ClassifyModel]?
    typealias addDataBlock = ()->Void
    var updateBlock:addDataBlock?
}
extension HomeClassifyViewModel{
    func refreshDataScoure(){
        HomeClassifyProvider.request(FMClassifyApi.classifyList, completion: {result in
            if case let .success(respone) = result{
                let data = try? respone.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HomeClassifyModel>.deserializeFrom(json: json.description){
                    self.classifyModel = mappedObject.list
                }
                self.updateBlock?()
                
                
            }
        })
    }
}
