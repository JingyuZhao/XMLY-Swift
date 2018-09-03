//
//  FMRecommendGridCell.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/9/3.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit

class FMRecommendGridCell: UICollectionViewCell {
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel:UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    var square:SquareModel?{
        didSet{
            guard let model = square else {return}
            self.titleLabel.text = model.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(self.imageView.snp.bottom).offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
