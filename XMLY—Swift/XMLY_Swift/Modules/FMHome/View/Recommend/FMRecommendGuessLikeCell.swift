//
//  FMRecommendGuessLikeCell.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/8/31.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

protocol FMRecommendGuessLikeCellDelegate:NSObjectProtocol {
    func recommendGuessLikeCellItemClick(model:RecommendListModel)
}

class FMRecommendGuessLikeCell: UICollectionViewCell {
    weak var delegate:FMRecommendGuessLikeCellDelegate?
    private var recommendList:[RecommendListModel]?
    private let FMGuessYouLikeCellID = "FMGuessYouLikeCellID"
    
    private lazy var changeBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor( UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1), for: .normal)
        button.backgroundColor = UIColor.init(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
        layer.masksToBounds = true
        layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(updateBtnClick(button:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        collection.alwaysBounceVertical = true
        collection.register(FMGuessYouLikeCell.self, forCellWithReuseIdentifier: FMGuessYouLikeCellID)
        
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var recommendListData:[RecommendListModel]? {
        didSet{
            guard let model = recommendListData else { return }
            self.recommendList = model
            self.collectionView.reloadData()
        }
    }
    // 更换一批按钮刷新cell
    @objc func updateBtnClick(button:UIButton){
        //首页推荐接口请求
        FMRecommendProvider.request(.changeGuessYouLikeList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<RecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.recommendList = mappedObject as? [RecommendListModel]
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func setUpUI(){
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
}
extension FMRecommendGuessLikeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FMGuessYouLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMGuessYouLikeCellID, for: indexPath) as! FMGuessYouLikeCell
        cell.recommendData = self.recommendList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recommendGuessLikeCellItemClick(model: (self.recommendList?[indexPath.row])!)
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 0, 5, 0);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(FMScreenWidth-55)/3,height:180)
    }
}
