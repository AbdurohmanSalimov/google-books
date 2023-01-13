//
//  MainViewController.swift
//  google books
//
//  Created by Azizbek Salimov on 09/01/23.
//

import UIKit
import SDWebImage


class HomeViewController: UIViewController {
    
    var baseView: HomeView = HomeView()
    let searchController = UISearchController()
    var books: [BookDM] = []
    var favoriteBooks: [String] = UserDefaults.standard.stringArray(forKey: "FavoriteBooks") ?? []
    var searchingText: String? = UserDefaults.standard.string(forKey: "searchText") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteBooks = UserDefaults.standard.stringArray(forKey: "FavoriteBooks") ?? []
        var searchingText: String? = UserDefaults.standard.string(forKey: "searchText") ?? ""
        if let searchingTextSafe = searchingText {
            getBooks(Search: searchingTextSafe)
     
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNavigationBar()
        callBaseView()
        setupBaseViewTargets()
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search"
        UINavigationBar.appearance().isTranslucent = false
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = .black
        searchController.searchBar.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.6705882353, blue: 0, alpha: 1)
        searchController.searchBar.barTintColor = .black
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.tintColor = .systemGray2
        searchController.searchBar.searchTextField.backgroundColor = .white
        
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
    
    func getBooks(Search keyWord: String ) {
        BookAPI.getBooks(keyWord: keyWord) { data in
            self.books = []
            if let books = data {
                self.books = books
                self.dismiss(animated: false)
            } else {
                print("error")
                self.showAlertWrong()
             
            }
            self.baseView.tableView.reloadData()
        }
        
    }
    
    private func setupBaseViewTargets() {
        baseView.searchBtnAddTarget(target: self, action: #selector(searchBtnPressed) )
    }
    
    private func setupTableView(){
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = self
    }
    

    @objc func searchBtnPressed(_ sender: AnyObject) {
        baseView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        searchController.searchBar.becomeFirstResponder()
    }
 
    
    
}

//MARK: UISearchbar delegated
extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchingText =  self.searchController.searchBar.text ?? "муму"
        UserDefaults.standard.setValue(searchingText, forKey: "searchText")
        getBooks(Search: searchingText!)
        searchController.searchBar.resignFirstResponder()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = baseView.tableView.dequeueReusableCell(withIdentifier: HomeTVC.identifier, for: indexPath) as? HomeTVC else { return UITableViewCell() }
        let book = books[indexPath.row]
        if favoriteBooks.contains(book.id) {
            cell.favorites.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.favorites.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookUrl = books[indexPath.row].volumeInfo.infoLink
        guard let url = URL(string: bookUrl ) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func favoriteBtnPressed(sender: UIButton ){
        var bookId = books[sender.tag].id
        if favoriteBooks.contains(bookId) {
            for i in favoriteBooks.enumerated() {
                if bookId == i.element {
                    favoriteBooks.remove(at: i.offset)
                    break
                }
            }
        } else {
            favoriteBooks.append(bookId)
        }
        
        UserDefaults.standard.set(favoriteBooks, forKey: "FavoriteBooks")
        baseView.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
}
