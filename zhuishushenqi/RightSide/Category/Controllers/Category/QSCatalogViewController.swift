//
//  QSCatalogViewController.swift
//  zhuishushenqi
//
//  Created caonongyun on 2017/4/21.
//  Copyright © 2017年 QS. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class QSCatalogViewController: BaseViewController ,UITableViewDataSource,UITableViewDelegate,CategoryCellItemDelegate, QSCatalogViewProtocol {

	var presenter: QSCatalogPresenterProtocol?
    
    var viewModel:ZSCatelogViewModel = ZSCatelogViewModel()

    var id:String? = ""
    var books:[[NSDictionary]] = []
    
    fileprivate var male:NSArray? = []
    fileprivate var female:NSArray? = []
    
    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = 50
        tableView.sectionFooterHeight = 10
        tableView.rowHeight = 93
        tableView.qs_registerCellNib(CategoryCell.self)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
//        presenter?.viewDidLoad()
        viewModel.request { (_) in
            self.tableView.reloadData()
        }
        self.automaticallyAdjustsScrollViewInsets = false
        title = "分类"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutSubview()
    }
    
    override func viewWillLayoutSubviews() {
        layoutSubview()
    }
    
    private func layoutSubview() {
        tableView.snp.remakeConstraints { (make) in
            let statusHeight = UIApplication.shared.statusBarFrame.height
            let navHeight = self.navigationController?.navigationBar.height ?? 0
            make.left.bottom.right.equalToSuperview()
            make.top.equalToSuperview().offset(statusHeight + navHeight)
        }
    }
    
    //CategoryCellDelegate
    func didSelected(at:Int,cell:CategoryCell){
        let indexPath = tableView.indexPath(for: cell) ?? IndexPath(row: 0, section: 0)
        let items = viewModel.catelogModel.items(at: indexPath.section)
        let item = items[at]
        let gender = viewModel.catelogModel.gender(for: indexPath.section)
        let parameterModel = ZSCatelogParameterModel(major:item.name, gender:gender)
        let detailVC = ZSCatelogDetailViewController()
        detailVC.parameterModel = parameterModel
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel.catelogModel.sections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let items = viewModel.catelogModel.items(at: indexPath.section)
        let count = ((items.count)%3 == 0 ? (items.count)/3:(items.count)/3 + 1)
        let height = count * 60
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CategoryCell? = tableView.qs_dequeueReusableCell(CategoryCell.self)
        cell?.backgroundColor = UIColor.white
        cell?.selectionStyle = .none
        let items = viewModel.catelogModel.items(at: indexPath.section)
        cell?.models = items
        cell?.itemDelegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableView.sectionFooterHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let name = viewModel.catelogModel.name(for: section)
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: 200, height: 50))
        label.text = name
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        headerView.addSubview(label)
        return headerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showData(models:[[NSDictionary]]){
        self.books = models
        self.tableView.reloadData()
    }

}
