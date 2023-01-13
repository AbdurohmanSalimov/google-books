//
//  FavoritesView.swift
//  google books
//
//  Created by Azizbek Salimov on 12/01/23.
//

import UIKit
import SnapKit

class FavoriteView: UIView {

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
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        addViews()
        addConstraints()
    }
    
    private func addViews() {
        addSubview(baseView)
        baseView.addSubview(tableView)
        
    }
    
    private func addConstraints() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.right.equalTo(baseView.snp.right)
            make.left.equalTo(baseView.snp.left)
            make.bottom.equalTo(baseView.snp.bottom)
            make.top.equalTo(baseView.snp.top)
            
        }

       
    }

}
