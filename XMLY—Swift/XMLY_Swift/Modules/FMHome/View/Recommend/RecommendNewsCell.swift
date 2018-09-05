//
//  RecommendNewsCell.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/9/3.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit

class RecommendNewsCell: UICollectionViewCell {
    private var topBuzz:[TopBuzzModel]?
    
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "news.png")
        return imageView
    }()
    
    private var moreBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("|  更多", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    private lazy var collectionView:UICollectionView = {
       let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize.init(width: FMScreenWidth - 150, height: 40)
    
        let collection = UICollectionView.init(frame: CGRect.init(x: 80, y: 5, width: FMScreenWidth - 150, height: 40), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.contentSize = CGSize.init(width: FMScreenWidth - 150, height: 40)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.isScrollEnabled = false
        collection.register(NewsCell.self, forCellWithReuseIdentifier: "NewsCellID")
        return collection
    }()
    
    var topBuzzList:[TopBuzzModel]?{
        didSet{
            guard let model = topBuzzList else {return}
            self.topBuzz = model
            self.collectionView.reloadData()
        }
    }
    
    
    var timer:Timer?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //设置UI
    func setUI() -> Void {
        addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.top.equalTo(10)
        }
        
        addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.top.equalTo(5)
        }
        
        addSubview(self.collectionView)
    }
    //定时器
    func setTimer() -> Void {
        
    }
    
}
extension RecommendNewsCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.topBuzz?.count ?? 0)*100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:NewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCellID", for: indexPath) as! NewsCell
        cell.titleLabel.text = self.topBuzzList?[indexPath.row%(self.topBuzz?.count)!].title
        return cell
    }
}
class NewsCell: UICollectionViewCell {
    lazy var titleLabel:UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.top.height.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
