//
//  Helper.swift
//  BiblioMobile
//
//  Created by Radhia MIGHRI on 9/3/2022.
//

import UIKit

class Helper {
    // Show error view
    static func showErrorView(title: String, message: String, target: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { _ in
        }))
        target.present(alert, animated: true, completion: nil)
    }
}
