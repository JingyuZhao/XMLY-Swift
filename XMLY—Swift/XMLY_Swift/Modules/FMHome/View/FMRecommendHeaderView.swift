//
//  FMRecommendHeaderView.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/8/31.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit
//创建闭包
typealias HeaderMoreBtnClick = ()->Void

class FMRecommendHeaderView: UICollectionReusableView {

    var headerMoreClick : HeaderMoreBtnClick?
    
    //标题
    private var titleLabel:UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }();
    
    //子标题
    private var subLabel:UILabel = {
        let label =  UILabel.init()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
        return label
    }();
    
    private var moreBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("更多 >", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(moreBtn(button:)), for: .touchUpInside)
        return button
    }();
    
    @objc func moreBtn(button:UIButton) {
        guard let headerMoreBtnClick = headerMoreClick else {
            return
        }
        headerMoreBtnClick()
    }
    
    var homeRecommendList:HomeRecommendModel? {
        didSet{
            guard let model = homeRecommendList else { return }
            self.titleLabel.text = model.title != nil ? model.title:"猜你喜欢"
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        addSubview(self.titleLabel)
        self.titleLabel.text = "猜你喜欢"
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.size.equalTo(CGSize.init(width: 150, height: 30))
        }
        
        addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.right)
            make.height.top.equalTo(self.titleLabel)
            make.right.equalToSuperview().offset(-100)
        }
        
        addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(15)
            make.size.equalTo(CGSize.init(width: 100, height: 30))
        }
    }
    
    
    
}
