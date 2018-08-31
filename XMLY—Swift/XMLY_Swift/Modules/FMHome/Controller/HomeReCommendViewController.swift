//
//  HomeReCommendViewController.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/8/31.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit
import SwiftMessages
import SnapKit

class HomeReCommendViewController: BaseViewController {

    let otherMessages = SwiftMessages()
    //穿插的广告数据
    private var recommendAdvertlist:[RecommendAdvertModel]?
    //MARK -Cell 重用标识
    private let FMRecommendHeaderViewID = "FMRecommendHeaderViewID"
    private let FMRecommendFooterViewID = "FMRecommendFooterViewID"
    
    private let FMRecommendHeaderCellID = "FMRecommendHeaderCellID"
    private let FMRecommendGuessLikeCellID = "FMRecommendGuessLikeCellID"
    private let FMHotAudiobookCellID = "FMHotAudiobookCellID"
    private let FMAdvertCellID = "FMAdvertCellID"
    private let FMOneKeyListenCellID = "FMOneKeyListenCellID"
    private let FMRecommendForYouCellID = "FMRecommendForYouCellID"
    private let FMHomeRecommendLiveCellID = "FMHomeRecommendLiveCellID"
    
    //Lazy Collection
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
//        collection.delegate = self
//        collection.dataSource = self
        collection.register(FMRecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FMRecommendHeaderCellID)
        collection.register(FMRecommendFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: FMRecommendFooterViewID)
        
        collection.register(FMRecommendHeaderCell.self, forCellWithReuseIdentifier: FMRecommendHeaderCellID)
        collection.register(FMRecommendGuessLikeCell.self, forCellWithReuseIdentifier: FMRecommendGuessLikeCellID)
        collection.register(FMAdvertCell.self, forCellWithReuseIdentifier: FMAdvertCellID)
        collection.register(FMHotAudiobookCell.self, forCellWithReuseIdentifier: FMHotAudiobookCellID)
        collection.register(FMOneKeyListenCell.self, forCellWithReuseIdentifier: FMOneKeyListenCellID)
        collection.register(FMHomeRecommendLiveCell.self, forCellWithReuseIdentifier: FMHomeRecommendLiveCellID)
        
        return collection;
    }()
    
    lazy var viewModel:HomeRecommendViewModel = {
        return HomeRecommendViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollection()
        loadData()
        loadRecommendAdvertData()
    }
    
    ///MARK - 创建UICollectionView
    func createCollection() {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        self.collectionView.uHead.beginRefreshing()
        
    }
    
    ///MARK - 加载数据
    func loadData(){
        
    }
    
    ///MARK - 加载广告数据
    func loadRecommendAdvertData(){
        
    }
    
}
//extension HomeReCommendViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//
//}
