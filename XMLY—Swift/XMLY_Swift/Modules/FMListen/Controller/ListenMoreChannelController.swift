//
//  ListenMoreChannelController.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/9/4.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class ListenMoreChannelController: BaseViewController {

    private var channelClassInfo:[ChannelClassInfoModel]?
    private var channelInfo:[ChannelInfosModel]?
    // 标志最后一次选中的左边的cell
    private var lastPath:IndexPath?
    
    private let LeftTableViewCellID = "OneKeyListenLTCell"
    private let RightTableViewCellID = "ListenChannelCell"
    
    /// 懒加载左边tableview
    private lazy var leftTableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:FMScreenWidth*0.2, height:FMScreenHeigth))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(OneKeyListenLTCell.self, forCellReuseIdentifier: LeftTableViewCellID)
        // 左边cell默认选中第一个cell
        self.lastPath = IndexPath(row: 0, section: 0)
        return tableView
    }()
    
    /// 懒加载右边tableview
    private lazy var rightTableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:FMScreenWidth*0.2, y:0, width:FMScreenWidth*0.8, height: FMScreenHeigth), style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(ListenChannelCell.self, forCellReuseIdentifier: RightTableViewCellID)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "更多频道"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.leftTableView)
        self.view.addSubview(self.rightTableView)
        loadData()
    }

    func loadData(){
        //1 获取json文件路径
        let path = Bundle.main.path(forResource: "listenMoreChannel", ofType: "json")
        //2 获取json文件里面的内容,NSData格式
        let jsonData=NSData(contentsOfFile: path!)
        //3 解析json内容
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<ChannelClassInfoModel>.deserializeModelArrayFrom(json: json["classInfos"].description) {
            self.channelClassInfo = mappedObject as? [ChannelClassInfoModel]
        }
    }
}
// Mark: - tableviewDelegate
extension ListenMoreChannelController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.leftTableView {
            return 1
        }
        return self.channelClassInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.leftTableView {
            return self.channelClassInfo?.count ?? 0
        }
        return self.channelClassInfo?[section].channelInfos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.leftTableView {
            return 80
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.leftTableView {
            let cell:OneKeyListenLTCell = tableView.dequeueReusableCell(withIdentifier: LeftTableViewCellID, for: indexPath) as! OneKeyListenLTCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.channelClassInfo = self.channelClassInfo?[indexPath.row]
            // 区分选中和未选中改变字体颜色和是否显示竖条
            let row = indexPath.row
            let oldRow = self.lastPath?.row
            if row == oldRow && self.lastPath != nil {
                cell.titleLabel.textColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
                cell.lineView.isHidden = false
            }else {
                cell.titleLabel.textColor = UIColor.black
                cell.lineView.isHidden = true
            }
            
            return cell
        }else {
            let cell:ListenChannelCell = tableView.dequeueReusableCell(withIdentifier: RightTableViewCellID, for: indexPath) as! ListenChannelCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.channelInfoModel = self.channelClassInfo?[indexPath.section].channelInfos?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.leftTableView {
            return 0
        }
        return 40
    }
    
    // 右边tableview headerView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x:20, y:0, width:80, height:40)
        let titleName:String = (self.channelClassInfo?[section].className)!
        let count:Int = (self.channelClassInfo?[section].channelInfos?.count)!
        titleLabel.text = "\(titleName)(\(count))"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.lightGray
        headerView.addSubview(titleLabel)
        let lineView = UIView()
        lineView.frame = CGRect(x:80, y:20,width:FMScreenWidth*0.8-100, height:0.5)
        lineView.backgroundColor = UIColor.lightGray
        headerView.addSubview(lineView)
        headerView.backgroundColor = UIColor.white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView()
        footView.backgroundColor = UIColor.white
        return footView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  点击左边tableview 让右边滚动到指定的分区, 这里要让上次选中的左边的cell字体颜色和竖条显示变黑
        //  本次选中变亮色
        if tableView == self.leftTableView {
            let newRow = indexPath.row
            let oldRow = (self.lastPath != nil) ? self.lastPath?.row:-1
            if newRow != oldRow {
                let newCell:OneKeyListenLTCell = tableView.cellForRow(at: indexPath) as! OneKeyListenLTCell
                newCell.titleLabel.textColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
                newCell.lineView.isHidden = false
                
                let oldCell:OneKeyListenLTCell = tableView.cellForRow(at: self.lastPath!) as! OneKeyListenLTCell
                oldCell.titleLabel.textColor = UIColor.black
                oldCell.lineView.isHidden = true
            }
            self.lastPath = indexPath
            let rightMoveToIndexPath  = IndexPath(row: 0, section: indexPath.row)
            self.rightTableView .selectRow(at: rightMoveToIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.top)
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.rightTableView {
            // 取出当前视图区域在最上面的cell得indexpath
            let topHeaderViewIndexPath = self.rightTableView.indexPathsForVisibleRows?.first
            // 让左边tableview 滚动到指定cell
            let leftMoveToIndexPath = IndexPath(row: (topHeaderViewIndexPath?.section)!, section: 0)
            
            let newRow = topHeaderViewIndexPath?.section
            let oldRow = (self.lastPath != nil) ? self.lastPath?.row:-1
            if newRow != oldRow {
                let newCell:OneKeyListenLTCell = self.leftTableView.cellForRow(at: leftMoveToIndexPath) as! OneKeyListenLTCell
                newCell.titleLabel.textColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
                newCell.lineView.isHidden = false
                
                let oldCell:OneKeyListenLTCell = self.leftTableView.cellForRow(at: self.lastPath!) as! OneKeyListenLTCell
                oldCell.titleLabel.textColor = UIColor.black
                oldCell.lineView.isHidden = true
            }
            self.lastPath = leftMoveToIndexPath
            self.leftTableView.selectRow(at: leftMoveToIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
        }
    }
    
}
