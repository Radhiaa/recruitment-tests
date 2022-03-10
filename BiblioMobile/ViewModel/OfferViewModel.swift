//
//  OfferViewModel.swift
//  BiblioMobile
//
//  Created by Radhia MIGHRI on 9/3/2022.
//

import UIKit

@available(iOS 13.0, *)
class OfferViewModel {
    
    // MARK: - Functions
    func getCommercialOfferData(target: UIViewController, urlString: String, completionHandler: @escaping OffersCallback) {
        guard Reachability.isConnectedToNetwork() else {
            Helper.showErrorView(title: "Info", message: "Pas de connexion internet disponible", target: target)
            return
        }
        guard let requestURL = URL(string: urlString) else { return }
        Service.shared.getOffers(requestURL, callback: { offers, _  in
            DispatchQueue.main.async {
                completionHandler(offers, nil)
            }
        })
    }
}
