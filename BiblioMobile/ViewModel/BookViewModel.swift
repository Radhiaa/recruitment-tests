//
//  BookViewModel.swift
//  BiblioMobile
//
//  Created by Radhia MIGHRI on 9/3/2022.
//

import UIKit

@available(iOS 13.0, *)
class BookViewModel {
    
    // MARK: - Functions
    func getBooksData(target: UIViewController, urlString: String, completionHandler: @escaping BooksCallback) {
        guard Reachability.isConnectedToNetwork() else {
            Helper.showErrorView(title: "Info", message: "Pas de connexion internet disponible", target: target)
            return
        }
        guard let requestURL = URL(string: urlString) else { return }
        Service.shared.getData(requestURL, callback: { books, _  in
            DispatchQueue.main.async {
                completionHandler(books, nil)
            }
        })
    }
}
