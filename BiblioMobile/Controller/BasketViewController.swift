//
//  BasketViewController.swift
//  BiblioMobile
//
//  Created by Radhia MIGHRI on 9/3/2022.
//

import UIKit

class BasketViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var booksSelectedTableView: UITableView!
    @IBOutlet weak var priceDiscount: UILabel!
    
    // MARK: - Variables
    var offers: [Offer]!
    var books: [Book]!
    var isbns: [String]!
    var offerVM = OfferViewModel()
    
    // MARK: - Functions
    override func viewDidLoad() {
        
        // Set tableview celle height
        self.booksSelectedTableView.rowHeight = 180.0
        getCommercialOfferData()
    }
    func getCommercialOfferData() {
        for book in books {
            isbns.append(book.isbn)
        }
        guard isbns.count > 0 else {
            return
        }
        let joinedISBN = isbns.joined(separator: ",")
        let urlString = "\(Constants.getCommercialOfferURL)\(joinedISBN)/commercialOffers"
        
        offerVM.getCommercialOfferData(target: self, urlString: urlString) { offers, _ in
            self.offers = offers
            self.priceDiscount.text = "Prix promotionnel: \(self.getBestPrice())"
            self.booksSelectedTableView.reloadData()
        }
    }
    func getBestPrice() -> Int {
        var totalPrice = 0
        var finalPrice = 0
        var prices = [Int]()
        for index in 0...self.books.count-1 {
            totalPrice += self.books[index].price
        }
        
        for offer in offers {
            if offer.type == "percentage" {
                let finalPricePer = totalPrice - totalPrice * (offer.value!/100)
                prices.append(finalPricePer)
            } else if offer.type == "minus" {
                let finalPriceMin = totalPrice - offer.value!
                prices.append(finalPriceMin)
            } else if offer.type == "slice" {
                let finalPriceSli = totalPrice - 12 * (offer.value!/offer.sliceValue!)
                prices.append(finalPriceSli)
            }
            finalPrice = prices.min()!
        }
        return finalPrice
    }
}

// MARK: - Extensions & Delegates
@available(iOS 13.0, *)
extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = books[indexPath.row]
        cell.setData(cellVM)
        
        return cell
    }
}
