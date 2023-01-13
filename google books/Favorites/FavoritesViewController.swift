//
//  FavoritesViewController.swift
//  google books
//
//  Created by Azizbek Salimov on 09/01/23.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var baseView: FavoriteView = FavoriteView()
    var tappedFavoriteAtRow: Int?
    var books: [BookDM] = []
    var favoriteBooks: [String] = UserDefaults.standard.stringArray(forKey: "FavoriteBooks") ?? []
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoriteBooks()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNavigationBar()
        callBaseView()
   

    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "My Favorite Books"
        UINavigationBar.appearance().isTranslucent = false

             let appearance = UINavigationBarAppearance()
             appearance.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.6705882353, blue: 0, alpha: 1)
             appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

             navigationController?.navigationBar.tintColor = .white
             navigationController?.navigationBar.standardAppearance = appearance
             navigationController?.navigationBar.compactAppearance = appearance
             navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
    }
    
   
    
    private func callBaseView() {
        baseView.frame = view.bounds
        view.addSubview(baseView)
    
       

    }
    
    func getFavoriteBooks(){
        self.books = []
        favoriteBooks = UserDefaults.standard.stringArray(forKey: "FavoriteBooks") ?? []
        for i in favoriteBooks {
            getBooks(favoriteBookId: i)
              }
        baseView.tableView.reloadData()
    }
    
    func getBooks(favoriteBookId: String ) {
        
        BookAPI.getFavoriteBooks(bookId: favoriteBookId) { data in
            if let book = data {
                self.books.append(book)
                self.baseView.tableView.reloadData()
                self.dismiss(animated: false)
            } else {
                print("error")
            }
        }
       
    }
    
    
    private func setupTableView(){
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = self
    }
    
    
}


extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = baseView.tableView.dequeueReusableCell(withIdentifier: HomeTVC.identifier, for: indexPath) as? HomeTVC else { return UITableViewCell() }
        let book = books[indexPath.row]
            cell.favorites.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        
        var authors = ""
        if !book.volumeInfo.authors.isEmpty {
            for i in book.volumeInfo.authors {
                authors.append(i + " ")
            }
        } else {
            authors = "No author mantioned"
        }
        
        cell.setupCell()
        cell.addTargetTVC(target: self, action: #selector(favoriteBtnPressed), cellForRow: indexPath)
        cell.bookImg.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.6705882353, blue: 0, alpha: 1)
        cell.updateCell(bookImageURL: book.volumeInfo.imageLinks.thumbnail ?? "error", bookName: book.volumeInfo.title, description: book.volumeInfo.description, author: authors, fsqId: book.id, isFavorites: true)
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            self.favoriteBooks.remove(at: indexPath.row)
            UserDefaults.standard.set(self.favoriteBooks, forKey: "FavoriteBooks")
            self.books.remove(at: indexPath.row)
            self.baseView.tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookUrl = books[indexPath.row].volumeInfo.infoLink
        guard let url = URL(string: bookUrl ) else { return }
        UIApplication.shared.open(url)
    }
    
    
    @objc func favoriteBtnPressed(sender: UIButton ){
        var number: Int? = nil
        let alert = UIAlertController(title: "Are you sure want to delete", message: "Your book will be deleted from the list of favorites.", preferredStyle: .alert)
        let cancelM = UIAlertAction(title: "cancel", style: .cancel)
        let deleteM = UIAlertAction(title: "delete", style: .destructive, handler: { _ in
            if number != nil {
                self.favoriteBooks.remove(at: number!)
                self.books.remove(at: sender.tag)
                UserDefaults.standard.set(self.favoriteBooks, forKey: "FavoriteBooks")
                self.getFavoriteBooks()
                self.baseView.tableView.reloadData()
                self.dismiss(animated: true)
            }
        })
        alert.addAction(cancelM)
        alert.addAction(deleteM)
        
        var bookId = books[sender.tag].id
        for i in favoriteBooks.enumerated() {
            if bookId == i.element {
                number = i.offset
              self.present(alert, animated: true)
                break
            }
        }
        print("🇺🇿 favorite-",favoriteBooks[sender.tag]," books-", books[sender.tag].id)
    
        baseView.tableView.reloadData()
    }
}
