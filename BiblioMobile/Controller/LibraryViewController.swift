//
//  LibraryViewController.swift
//  BiblioMobile
//
//  Created by Radhia MIGHRI on 8/3/2022.
//

import UIKit

class LibraryViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - @IBOutlets
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var booksTableView: UITableView!
    
    // MARK: - Variables
    var books = [Book]()
    var booksSelected = [Book]()
    var importSelectedIDs = [String]()
    var searching: Bool! = false
    var bookVM = BookViewModel()
    var tagsDisabled = [Int]()
    
    // MARK: - Functions
    override func viewDidLoad() {
        
        // Set navigation Bar
        navigationViewBar()
        // Set tableview celle height
        self.booksTableView.rowHeight = 240.0
        // Get Books library
        getBooksData()
        // setup search bar
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        
    }
    func navigationViewBar() {
        let myimage = UIImage(named: "panel_icon")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: myimage, style: .plain, target: self, action: #selector(addToPanel))
    }
    
    @objc func addToPanel() {
        if booksSelected.count > 0 {
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "BasketViewController") as! BasketViewController
            vController.books = booksSelected
            vController.isbns = importSelectedIDs
            self.navigationController?.pushViewController(vController, animated: true)
        } else {
            Helper.showErrorView(title: "Info", message: "Vous n'avez pas encore effectué des achats", target: self)
        }
    }
    
    func getBooksData() {
        bookVM.getBooksData(target: self, urlString: Constants.getBooksURL) { books, _ in
            self.books = books
            self.booksTableView.reloadData()
        }
    }
    
    // config search bar
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searching = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.endEditing(true)
    }
    // Search specific contact
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        books = searchText.isEmpty ? books : books.filter({(book: Book) -> Bool in
            let title = book.title
            // If dataItem matches the searchText, return true to include it
            return title!.range(of: searchText, options: .caseInsensitive) != nil
        })
        booksTableView.reloadData()
    }
    
    @objc func addToBasket(_ sender: UIButton) {
        let buttonTag = sender.tag
        booksSelected.append(books[buttonTag])
        tagsDisabled.append(buttonTag)
        booksTableView.reloadData()
    }
}

// MARK: - Extensions & Delegates
@available(iOS 13.0, *)
extension LibraryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        cell.addButton.layer.cornerRadius = 5
        cell.addButton?.layer.masksToBounds = true
        
        // assign the index of the youtuber to button tag
        cell.addButton.tag = indexPath.row
        
        // call the subscribeTapped method when tapped
        cell.addButton.addTarget(self, action: #selector(addToBasket(_:)), for: .touchUpInside)
        
        if tagsDisabled.contains(indexPath.row) {
            cell.addButton.isEnabled = false
        }
        let cellVM = books[indexPath.row]
        cell.setData(cellVM)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // self.checkSelect(tableView, indexPath: indexPath)
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "BookDetailsViewController") as! BookDetailsViewController
        vController.book = books[indexPath.row]
        self.navigationController?.pushViewController(vController, animated: true)
    }
}
