//
//  FMRecommendFooterView.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/8/31.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit

class FMRecommendFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
