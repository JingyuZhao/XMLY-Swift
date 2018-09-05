//
//  OneKeyListenLTCell.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/9/4.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit

class OneKeyListenLTCell: UITableViewCell {

    // 竖线
    var lineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
        view.isHidden = true
        return view
    }()
    // 名字
    var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(4)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(30)
            make.left.equalTo(self.lineView.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    var channelClassInfo: ChannelClassInfoModel? {
        didSet {
            guard let model = channelClassInfo else {return}
            self.titleLabel.text = model.className
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //        self.titleLabel.textColor = DominantColor
        //        self.lineView.isHidden = false
        // Configure the view for the selected state
    }

}
