//
//  Service.swift
//  BiblioMobile
//
//  Created by Radhia MIGHRI on 8/3/2022.
//

import UIKit

typealias BooksCallback = ([Book], Error?) -> Void
typealias OffersCallback = ([Offer], Error?) -> Void

class Service {
    
    // MARK: - declarate shared propertie(singleton) to access helper functions
    static let shared = Service()
    
    func getData(_ url: URL, callback: @escaping BooksCallback) {
        URLSession.shared.dataTask(with: url) { (result, _, error) in
            guard let result = result else { return }
            
            do {
                let books = try JSONDecoder().decode([Book].self, from: result)
                callback(books, nil)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
    
    func getOffers(_ url: URL, callback: @escaping OffersCallback) {
        URLSession.shared.dataTask(with: url) { (result, _, error) in
            guard let result = result else { return }
            
            do {
                let offers = try JSONDecoder().decode(Offers.self, from: result)
                callback(offers.offers!, nil)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
}
