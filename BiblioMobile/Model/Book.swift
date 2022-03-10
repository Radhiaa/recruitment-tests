//
//  Book.swift
//  BiblioMobile
//
//  Created by Radhia MIGHRI on 8/3/2022.
//

import Foundation

// MARK: - Book
struct Book: Codable {
    let isbn, title: String!
    let price: Int!
    let cover: String!
    let synopsis: [String]!
}
