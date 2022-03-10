//
//  BookTableViewCell.swift
//  BiblioMobile
//
//  Created by Radhia MIGHRI on 8/3/2022.
//

import UIKit
import SDWebImage

class BookTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // set corner to price Label
        priceLabel.layer.cornerRadius = 30
        priceLabel?.layer.masksToBounds = true
    }
    
    func setData(_ book: Book) {
        titleLabel.text = book.title
        priceLabel.text = String(book.price) + " €"
        coverImageView.sd_setImage(with: URL(string : book.cover!), placeholderImage: nil)
    }
}
