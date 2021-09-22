//
//  SeachModel.swift
//  2mem
//
//  Created by Artem Firsov on 9/21/21.
//

import Foundation

struct SearchModel: Decodable {
    let total, totalPages: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Decodable {
    let width: Int
    let height: Int
    let id: String
    let urls: [URL.RawValue:String]
    
    enum URL: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
