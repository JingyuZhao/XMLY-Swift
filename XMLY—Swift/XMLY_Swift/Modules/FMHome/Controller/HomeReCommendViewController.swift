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
import SwiftyJSON
import HandyJSON

class HomeReCommendViewController: BaseViewController {

    let otherMessages = SwiftMessages()
    //穿插的广告数据
    private var recommendAdvertList:[RecommendAdvertModel]?
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
        collection.backgroundColor = UIColor.white
        collection.delegate = self
        collection.dataSource = self
        collection.register(FMRecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FMRecommendHeaderCellID)
        collection.register(FMRecommendFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: FMRecommendFooterViewID)
        
        collection.register(FMRecommendHeaderCell.self, forCellWithReuseIdentifier: FMRecommendHeaderCellID)
        collection.register(FMRecommendGuessLikeCell.self, forCellWithReuseIdentifier: FMRecommendGuessLikeCellID)
        collection.register(FMAdvertCell.self, forCellWithReuseIdentifier: FMAdvertCellID)
        collection.register(FMHotAudiobookCell.self, forCellWithReuseIdentifier: FMHotAudiobookCellID)
        collection.register(FMOneKeyListenCell.self, forCellWithReuseIdentifier: FMOneKeyListenCellID)
        collection.register(FMHomeRecommendLiveCell.self, forCellWithReuseIdentifier: FMHomeRecommendLiveCellID)
        
        collection.uHead = URefreshHeader{ [weak self] in self?.loadData() }
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
        self.viewModel.updateBlock = {[unowned self] in
            self.collectionView.uHead.endRefreshing()
            //更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataScoure()
    }
    
    ///MARK - 加载广告数据
    func loadRecommendAdvertData(){
        //首页穿插广告接口请求
        FMRecommendProvider.request(FMRecommendApi.recommendAdList, completion: { result in
            //解析数据
            if case let .success(respone) = result{
                let data = try? respone.mapJSON()
                let json = JSON(data!)
                if let advertList = JSONDeserializer<RecommendAdvertModel>.deserializeModelArrayFrom(json:json["data"].description){
                    self.recommendAdvertList = advertList as? [RecommendAdvertModel]
                    self.collectionView.reloadData()
                }
                
            }
        })
    }
    
}
extension HomeReCommendViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (self.viewModel.homeRecommendList?.count) ?? 0
    }

    // 每个分区显示item数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
     //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 0
    }

    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let HeaderAndFooterHeight:Int = 90
        let itemNums = (self.viewModel.homeRecommendList?[indexPath.section].list?.count)!/3
        let count = self.viewModel.homeRecommendList?[indexPath.section].list?.count
        let moduleType = self.viewModel.homeRecommendList?[indexPath.section].moduleType
        if moduleType == "focus" {
            return CGSize.init(width:FMScreenWidth,height:360)
        }else if moduleType == "square" || moduleType == "topBuzz" {
            return CGSize.zero
        }else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" || moduleType == "live"{
            return CGSize.init(width:FMScreenWidth,height:CGFloat(HeaderAndFooterHeight+180*itemNums))
        }else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
            return CGSize.init(width:FMScreenWidth,height:CGFloat(HeaderAndFooterHeight+120*count!))
        }else if moduleType == "ad" {
            return CGSize.init(width:FMScreenWidth,height:240)
        }else if moduleType == "oneKeyListen" {
            return CGSize.init(width:FMScreenWidth,height:180)
        }else {
            return .zero
        }
    }
     // 分区头视图size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let moduleType = self.viewModel.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" || moduleType == "ad" || section == 18 {
            return CGSize.zero
        }else {
            return CGSize.init(width: FMScreenWidth, height:40)
        }
    }
    
    // 分区尾视图size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let moduleType = self.viewModel.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" {
            return CGSize.zero
        }else {
            return CGSize.init(width: FMScreenWidth, height: 10.0)
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" {
            let cell:FMRecommendHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMRecommendHeaderCellID, for: indexPath) as! FMRecommendHeaderCell
            cell.focusModel = viewModel.focus
            cell.squareList = viewModel.squareList
            cell.topBuzzListData = viewModel.topBuzzList
            cell.delegate = self
            return cell
        }else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory"{
            ///横式排列布局cell
            let cell:FMRecommendGuessLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMRecommendGuessLikeCellID, for: indexPath) as! FMRecommendGuessLikeCell
            cell.delegate = self
            cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            return cell
        }else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
            // 竖式排列布局cell
            let cell:FMHotAudiobookCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMHotAudiobookCellID, for: indexPath) as! FMHotAudiobookCell
            cell.delegate = self
            cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            return cell
        }else if moduleType == "ad" {
            let cell:FMAdvertCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMAdvertCellID, for: indexPath) as! FMAdvertCell
            if indexPath.section == 7 {
                cell.adModel = self.recommendAdvertList?[0]
            }else if indexPath.section == 13 {
                cell.adModel = self.recommendAdvertList?[1]
                //            }else if indexPath.section == 17 {
                //                cell.adModel = self.recommnedAdvertList?[2]
            }
            return cell
        }else if moduleType == "oneKeyListen" {
            let cell:FMOneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMOneKeyListenCellID, for: indexPath) as! FMOneKeyListenCell
            cell.oneKeyListenList = viewModel.oneKeyListenList
            return cell
        }else if moduleType == "live" {
            let cell:FMHomeRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMHomeRecommendLiveCellID, for: indexPath) as! FMHomeRecommendLiveCell
            cell.liveList = viewModel.liveList
            return cell
        }
        else {
            let cell:FMRecommendForYouCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMRecommendForYouCellID, for: indexPath) as! FMRecommendForYouCell
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        if kind == UICollectionElementKindSectionHeader {
            let headerView : FMRecommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FMRecommendHeaderCellID, for: indexPath) as! FMRecommendHeaderView
            headerView.homeRecommendList = viewModel.homeRecommendList?[indexPath.section]
            // 分区头右边更多按钮点击跳转
            headerView.headerMoreClick = {[weak self]() in
                if moduleType == "guessYouLike"{
//                    let vc = HomeGuessYouLikeMoreController()
//                    self?.navigationController?.pushViewController(vc, animated: true)
                }else if moduleType == "paidCategory" {
//                    let vc = HomeVIPController(isRecommendPush:true)
//                    vc.title = "精品"
//                    self?.navigationController?.pushViewController(vc, animated: true)
                }else if moduleType == "live"{
//                    let vc = HomeLiveController()
//                    vc.title = "直播"
//                    self?.navigationController?.pushViewController(vc, animated: true)
                }else {
                    guard let categoryId = self?.viewModel.homeRecommendList?[indexPath.section].target?.categoryId else {return}
                    if categoryId != 0 {
//                        let vc = ClassifySubMenuController(categoryId:categoryId,isVipPush:false)
//                        vc.title = self?.viewModel.homeRecommendList?[indexPath.section].title
//                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            return headerView
        }else if kind == UICollectionElementKindSectionFooter {
            let footerView : FMRecommendFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: FMRecommendFooterViewID, for: indexPath) as! FMRecommendFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}
// Mark:- 点击顶部分类按钮进入相对应界面
extension HomeReCommendViewController:FMRecommendHeaderCellDelegate {
    func recommendHeaderBannerClick(url: String) {
        let status2 = MessageView.viewFromNib(layout: .statusLine)
        status2.backgroundView.backgroundColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
        status2.bodyLabel?.textColor = UIColor.white
        status2.configureContent(body: "哎呀呀!咋没反应呢???")
        var status2Config = SwiftMessages.defaultConfig
        status2Config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        status2Config.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: status2Config, view: status2)
    }
    
    func recommendHeaderBtnClick(categoryId:String,title:String,url:String){
        if url == ""{
            if categoryId == "0"{
                let warning = MessageView.viewFromNib(layout: .cardView)
                warning.configureTheme(.warning)
                warning.configureDropShadow()
                
                let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
                warning.configureContent(title: "Warning", body: "别点了,接口变了,暂时没数据啦!!!", iconText: iconText)
                warning.button?.isHidden = true
                var warningConfig = SwiftMessages.defaultConfig
                warningConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
                SwiftMessages.show(config: warningConfig, view: warning)
            }else{
//                let vc = ClassifySubMenuController(categoryId:Int(categoryId)!)
//                vc.title = title
//                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
//            let vc = FMWebViewController(url:url)
//            vc.title = title
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
// Mark: -点击猜你喜欢cell代理方法
extension HomeReCommendViewController:FMRecommendGuessLikeCellDelegate {
    func recommendGuessLikeCellItemClick(model: RecommendListModel) {
//        let vc = FMPlayDetailController(albumId: model.albumId)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// Mark: -点击热门有声书等cell代理方法
extension HomeReCommendViewController:FMHotAudiobookCellDelegate {
    func hotAudiobookCellItemClick(model: RecommendListModel) {
//        let vc = FMPlayDetailController(albumId: model.albumId)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
