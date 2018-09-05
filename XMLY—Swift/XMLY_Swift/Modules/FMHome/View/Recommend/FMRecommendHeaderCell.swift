//
//  FMRecommendHeaderCell.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/8/31.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit
import FSPagerView

///添加按钮点击代理方法
protocol FMRecommendHeaderCellDelegate:NSObjectProtocol {
    func recommendHeaderBtnClick(categoryId:String,title:String,url:String)
    func recommendHeaderBannerClick(url:String)
}

class FMRecommendHeaderCell: UICollectionViewCell {
    weak var delegate : FMRecommendHeaderCellDelegate?
    
    private var focus:FocusModel?
    private var square:[SquareModel]?
    private var topBuzzList:[TopBuzzModel]?
    ///MARK: - 懒加载滚动图片浏览器
    private lazy var pagerView:FSPagerView = {
        let pager = FSPagerView()
        pager.delegate = self
        pager.dataSource = self;
        pager.automaticSlidingInterval = 3;
        pager.isInfinite = true
        pager.interitemSpacing = 15
        pager.transformer = FSPagerViewTransformer.init(type: .linear)
        pager.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPageCell")
        
        return pager;
    }();
    
    private lazy var gridView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0 )
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.register(FMRecommendGridCell.self, forCellWithReuseIdentifier: "FMRecommendGridCellID")
        collection.register(RecommendNewsCell.self, forCellWithReuseIdentifier: "RecommendNewsCellID")
        
        return collection
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    // 初始化
    func setUpUI(){
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150)
        }
        self.addSubview(self.gridView)
        self.gridView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.pagerView.snp.bottom)
            make.height.equalTo(210)
        }
        self.pagerView.itemSize = CGSize.init(width: FMScreenWidth-60, height: 140)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var focusModel:FocusModel? {
        didSet{
            guard let model = focusModel else { return }
            self.focus = model
            self.pagerView.reloadData()
        }
    }
    
    var squareList:[SquareModel]? {
        didSet{
            guard let model = squareList else { return }
            self.square = model
            self.gridView.reloadData()
        }
    }
    
    var topBuzzListData:[TopBuzzModel]? {
        didSet{
            guard let model = topBuzzListData else { return }
            self.topBuzzList = model
            self.gridView.reloadData()
        }
    }
}
extension FMRecommendHeaderCell:FSPagerViewDelegate,FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.focus?.data?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPageCell", at: index)
        cell.imageView?.kf.setImage(with: URL.init(string: (self.focus?.data?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let url:String = self.focus?.data?[index].link ?? ""
        delegate?.recommendHeaderBannerClick(url: url)
        
    }
}
extension FMRecommendHeaderCell : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section==0 {
            let cell:FMRecommendGridCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FMRecommendGridCellID", for: indexPath) as! FMRecommendGridCell
            cell.square = self.square?[indexPath.row]
            return cell
        } else {
            let cell:RecommendNewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendNewsCellID", for: indexPath) as! RecommendNewsCell
            cell.topBuzzList = self.topBuzzList
            return cell;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return section==0 ? (self.square?.count ?? 0 ): 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.section == 0 ? CGSize.init(width: (FMScreenWidth - 5)/5, height: 80) : CGSize.init(width: FMScreenWidth, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("indexPath :%d %d", indexPath.section,indexPath.row)
    }
}
