//
//  RecommendLiveCell.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/9/3.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit

class RecommendLiveCell: UICollectionViewCell {
    // 图片
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    // 子标题
    private var subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    // categoryName
    private var categoryL : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.orange
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.imageView)
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 8
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        self.imageView.addSubview(self.categoryL)
        self.categoryL.layer.masksToBounds = true
        self.categoryL.layer.cornerRadius = 4
        self.categoryL.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
    
    var recommendliveData:LiveModel? {
        didSet{
            guard let model = recommendliveData else { return }
            if (model.coverMiddle != nil) {
                self.imageView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            self.titleLabel.text = model.nickname
            self.subLabel.text = model.name
            self.categoryL.text = model.categoryName
        }
    }
    
    var liveData:LiveModel? {
        didSet{
            guard let model = liveData else { return }
            if (model.coverMiddle != nil) {
                self.imageView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            self.titleLabel.text = model.nickname
            self.subLabel.text = model.name
            self.categoryL.text = model.categoryName
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
