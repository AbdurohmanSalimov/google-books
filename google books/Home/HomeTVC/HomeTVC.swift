//
//  HomeTVC.swift
//  google books
//
//  Created by Azizbek Salimov on 09/01/23.
//

import UIKit
import SDWebImage


class HomeTVC: UITableViewCell {
    
    
    
    static let identifier = "HomeTVC"
    
    var fsqId: String?
    
    let backView: UIView = {
        let view = UIView()
        
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.75).cgColor
        view.layer.borderWidth = 0.05
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 8, height: -8)
        view.layer.shadowRadius = 22
        view.layer.shadowOpacity = 0.1
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    private let bookNameLbl: UILabel = {
        let name = UILabel()
        name.font = UIFont(name: "Inter-Bold", size: 14)
        name.textColor = .black
        name.numberOfLines = 2
        name.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        
        return name
    }()
    
    
    private let author: UILabel = {
        let author = UILabel()
        author.font = UIFont(name: "Inter-Regular", size: 12)
        author.textColor = #colorLiteral(red: 0.4855533242, green: 0.7421357036, blue: 0.4231997132, alpha: 1)
        author.numberOfLines = 2
        return author
    }()
    
    private let definitionLbl: UILabel = {
        let definitionLbl = UILabel()
        definitionLbl.font = UIFont(name: "Inter-Regular", size: 10)
        definitionLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        definitionLbl.numberOfLines = 3
        return definitionLbl
    }()
    
    
    private let circleView: UIView = {
        let circle = UIView()
        circle.layer.cornerRadius = circle.frame.height / 2
        circle.clipsToBounds = true
        circle.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.6705882353, blue: 0, alpha: 1)
        
        return circle
    }()
    
    
    let bookImg: UIImageView = {
        let bookImg = UIImageView()
        bookImg.image = UIImage(systemName: "book")
        bookImg.tintColor = .black
        bookImg.backgroundColor = .clear
        bookImg.contentMode = .scaleAspectFit
        return bookImg
    }()
    
    let favorites: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.tintColor = .black
        btn.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            return btn
    }()
    
    
    
    func updateCell(bookImageURL: String , bookName: String, description: String, author: String, fsqId: String, isFavorites: Bool ){
        self.fsqId = fsqId
        self.bookImg.sd_setImage(with: URL(string: bookImageURL) , placeholderImage: UIImage(named: "bookM"))
        
        self.bookNameLbl.text = bookName
        self.definitionLbl.text = description
        self.author.text = author

    }
    
    private func setupViews() {
        
        self.contentView.addSubview(backView)
        backView.addSubview(containerView)
        containerView.addSubview(bookImg)
        containerView.addSubview(bookNameLbl)
        containerView.addSubview(definitionLbl)
        containerView.addSubview(circleView)
        circleView.addSubview(favorites)
        containerView.addSubview(author)

    }
    
    private func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(135)
            backView.layer.cornerRadius = 20
            backView.clipsToBounds = true
        }
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(backView)
            make.right.equalTo(backView)
            make.top.equalTo(backView)
            make.bottom.equalTo(backView)
            
        }
        
        bookImg.snp.makeConstraints { make in
            make.left.equalTo(containerView.snp.left)
            make.bottom.equalTo(containerView.snp.bottom)
            make.top.equalTo(containerView.snp.top)
            let number = containerView.snp.height
            make.width.equalTo(95)
        }
        
        circleView.snp.makeConstraints { make in
            make.right.equalTo(containerView.snp.right).offset(-16)
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.height.equalTo(60)
            circleView.layer.cornerRadius = 30
        }
        
        favorites.snp.makeConstraints { make in
            make.center.equalTo(circleView.snp.center)
            make.width.equalTo(circleView.snp.width)
            make.height.equalTo(circleView.snp.height)
        }
        
        bookNameLbl.snp.makeConstraints { make in
            make.left.equalTo(bookImg.snp.right).offset(10)
            make.top.equalTo(containerView.snp.top).offset(12)
            make.right.equalTo(circleView.snp.left).offset(-5)
            make.height.equalTo(34)
        }
        
        
        author.snp.makeConstraints { make in
            make.top.equalTo(bookNameLbl.snp.bottom).offset(6)
            make.left.equalTo(bookImg.snp.right).offset(10)
            make.right.equalTo(circleView.snp.left).offset(-10)
        }
        
        definitionLbl.snp.makeConstraints { make in
            make.top.equalTo(author.snp.bottom).offset(6)
            make.left.equalTo(bookImg.snp.right).offset(10)
            make.width.equalTo(bookNameLbl.snp.width).offset(-16)
            make.bottom.equalTo(containerView.snp.bottom).inset(12)
        }
        
        
        
        
        
    }
    
    func setupCell() {
        setupViews()
        setupConstraints()
        
    }
    
    func addTargetTVC(target: Any, action: Selector, cellForRow: IndexPath) {
        favorites.addTarget(target, action: action, for: .touchUpInside)
        favorites.tag = cellForRow.row
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
