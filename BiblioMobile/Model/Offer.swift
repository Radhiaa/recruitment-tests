//
//  Offer.swift
//  BiblioMobile
//
//  Created by Radhia MIGHRI on 8/3/2022.
//

import Foundation

// MARK: - Offer
struct Offer: Codable {
    let type: String?
    let value, sliceValue: Int?
}

struct Offers: Codable {
    let offers: [Offer]?
}

