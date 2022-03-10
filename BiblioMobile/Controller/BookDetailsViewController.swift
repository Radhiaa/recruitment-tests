//
//  BookDetailsViewController.swift
//  BiblioMobile
//
//  Created by Radhia MIGHRI on 8/3/2022.
//

import UIKit

class BookDetailsViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var synopsisTextView: UITextView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    // MARK: - Variables
    var book: Book!
    var syno = [String]()
    
    // MARK: - Functions
    override func viewDidLoad() {
        // Set book elements
        setBookDetails()
        // Disable textview editing
        synopsisTextView.isEditable = false
        
        // set corner to price Label
        priceLabel.layer.cornerRadius = 30
        priceLabel?.layer.masksToBounds = true
    }
    
    func setBookDetails() {
        titleLabel.text = book.title
        isbnLabel.text = "ISBN: " +  book.isbn
        priceLabel.text = String(book.price!) + "€"
        for index in 0...book.synopsis.count-1 {
            syno.append(book.synopsis![index])
        }
        synopsisTextView.text = syno.joined(separator: " \n")
        coverImageView.sd_setImage(with: URL(string : book.cover!), placeholderImage: nil)
    }
}
