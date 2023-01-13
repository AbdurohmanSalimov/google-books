//
//  MainView.swift
//  google books
//
//  Created by Azizbek Salimov on 09/01/23.
//


import UIKit
import SnapKit

class HomeView: UIView {
    
    let baseView: UIView = {
        let baseView = UIView()
        baseView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.9254902005, blue: 0.9254902005, alpha: 1)
        return baseView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 20, left: 0, bottom: 100, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(HomeTVC.self , forCellReuseIdentifier: HomeTVC.identifier)
        return tableView
    }()
    
    let searchBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 30
        btn.clipsToBounds = true
        
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addViews()
        addConstraints()
    }
    
    private func addViews() {
        addSubview(baseView)
        baseView.addSubview(tableView)
        baseView.addSubview(searchBtn)
        
    }
    
    private func addConstraints() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchBtn.snp.makeConstraints { make in
            make.right.equalTo(baseView.snp.right).offset(-60)
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.bottom.equalTo(baseView.snp.bottom).offset(-150)
        }
        
        tableView.snp.makeConstraints { make in
            make.right.equalTo(baseView.snp.right)
            make.left.equalTo(baseView.snp.left)
            make.bottom.equalTo(baseView.snp.bottom)
            make.top.equalTo(baseView.snp.top)
            
        }

    }
    
    func searchBtnAddTarget(target: Any, action: Selector ) {
        searchBtn.addTarget(target, action: action, for: .touchUpInside)
        
    }
    
    
    
    
    
}
