//
//  HomeClassifyViewController.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/8/31.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit

class HomeClassifyViewController: BaseViewController {

    private let CellIdentify = "HomeClassifyCell"
    private let HomeClassiyfHeaderViewID = "HomeClassiyfHeaderViewID"
    private let HomeClassifyFooterViewID = "HomeClassifyFooterViewID"
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)
        collection.register(HomeClassifyHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HomeClassiyfHeaderViewID)
        collection.register(HomeClassifyFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HomeClassifyFooterViewID)
        return collection
    }()
    
    private lazy var viewModel:HomeClassifyViewModel = {
        return HomeClassifyViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()
    }

    func setUI(){
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.top.height.equalToSuperview()
        }
    }
    
    func loadData(){
        self.viewModel.updateBlock = {[unowned self] in
            self.collectionView.reloadData()
        }
        self.viewModel.refreshDataScoure()
    }
}
extension HomeClassifyViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.classifyModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.classifyModel?[section].itemList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier:String = "\(indexPath.section)\(indexPath.row)"
        self.collectionView.register(HomeClassifyCell.self, forCellWithReuseIdentifier: identifier)
        let cell:HomeClassifyCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeClassifyCell
        cell.backgroundColor = UIColor.white
        cell.layer.masksToBounds =  true
        cell.layer.cornerRadius = 4.0
        cell.layer.borderColor = UIColor.init(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1).cgColor
        cell.layer.borderWidth = 0.5
        cell.itemModel = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let categoryId:Int = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row].itemDetail?.categoryId ?? 0
//        let title = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row].itemDetail?.title ?? ""
//        let vc = ClassifySubMenuController(categoryId: categoryId)
//        vc.title = title
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView : HomeClassifyHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HomeClassiyfHeaderViewID, for: indexPath) as! HomeClassifyHeaderView
            headerView.titleString = viewModel.classifyModel?[indexPath.section].groupName
            return headerView
        }else if kind == UICollectionElementKindSectionFooter {
            let footerView : HomeClassifyFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HomeClassifyFooterViewID, for: indexPath) as! HomeClassifyFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
    
    //flowLayout

    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsetsMake(0, 2.5, 0, 2.5)
    }
    //最小 item 间距
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            return CGSize.init(width:(FMScreenWidth-10)/4,height:40)
        }else {
            return CGSize.init(width:(FMScreenWidth-7.5)/3,height:40)
        }
    }
    
    // 分区头视图size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 || section == 1 || section == 2 {
            return .zero
        }else {
            return CGSize.init(width: FMScreenHeigth, height:30)
        }
    }
    
    // 分区尾视图size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: FMScreenWidth, height: 8.0)
    }

}
