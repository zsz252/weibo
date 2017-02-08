//
//  WBHomeViewController.swift
//  Weibo
//
//  Created by apple on 2017/1/13.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

//定义全局常量
private let cellId = "cellId"

class WBHomeViewController: WBBaseViewController {
    
    lazy var listViewModel = WBStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //加载数据
    override func loadDate() {
        
        listViewModel.loadStatus(pullup: self.isPullup) { (isSucess) in
            
            self.refreshControl?.endRefreshing()
            
            self.isPullup = false
            
            self.tableView?.reloadData()
        }
        
        //模拟延时加载
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//            
//            for i in 1...15{
//                //将数据插入数组顶部
//                if self.isPullup {
//                    //将数据加入数组底部
//                    self.statusList.append(i.description)
//                }else{
//                    //将数据加入数组顶部
//                    self.statusList.insert(i.description, at: 0)
//                }
//            }
//            //结束刷新控件
//            self.refreshControl?.endRefreshing()
//            
//            //恢复上拉标记
//            self.isPullup = false
//            
//            self.tableView?.reloadData()
//        }
    }
    
    //显示好友
    func showFriends(){
        navigationController?.pushViewController(WBDemoViewController(), animated: true)
    }
}


// MARK: - 表格数据源方法
extension WBHomeViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1.取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        //2.设置cell
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        //3.返回cell
        return cell
    }
}

// MARK: - 设置界面
extension WBHomeViewController{
    
    override func setupUI() {
        super.setupUI()
        
        tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
    }
}