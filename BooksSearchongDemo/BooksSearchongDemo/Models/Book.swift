//
//  Book.swift
//  BooksSearchongDemo
//
//  Created by Ruslan Yupyn on 09.02.2020.
//  Copyright © 2020 Ruslan Yupyn. All rights reserved.
//

import Foundation
import SwiftyJSON

class Book {
    var title: String!
    var hasFulltext: Bool!
    var editionCount: Int!
    var authorName: [String]!
    
    var coverId: Int?
    
    var firstPublishYear: Int!
    var key: String!
    var ia: [String]!
    var authorKey: [String]!
    var publicScanB: Bool!
    var isbn: [String]!
    var lccn: [String]!
    var oclc: [String]!
    //    var olid: [String]!
    
    init(json: JSON) {
        self.coverId = json["cover_i"].intValue
        self.hasFulltext = json["has_fulltext"].boolValue
        self.editionCount = json["edition_count"].intValue
        self.title = json["title"].stringValue
        self.authorName = (json["author_name"].arrayObject as? [String]) ?? []
        self.firstPublishYear = json["first_publish_year"].intValue
        self.key = json["key"].stringValue
        self.ia = (json["ia"].arrayObject as? [String]) ?? []
        self.authorKey = (json["author_key"].arrayObject as? [String]) ?? []
        self.publicScanB = json["public_scan_b"].boolValue
        self.isbn = (json["isbn"].arrayObject as? [String]) ?? []
        self.lccn = (json["lccn"].arrayObject as? [String]) ?? []
        self.oclc = (json["oclc"].arrayObject as? [String]) ?? []
    }
    
    func coverURL() -> URL? {
        var url: URL? = nil
        if let oclc = oclc.last,
            let oclcURL = URL(string: "http://covers.openlibrary.org/b/oclc/\(oclc)-M.jpg") {
            url = oclcURL
        } else if let lccn = lccn.last,
            let lccnURL = URL(string: "http://covers.openlibrary.org/b/lccn/\(lccn)-M.jpg") {
            url = lccnURL
        } else if let isbn = isbn.last,
            let isbnURL = URL(string: "http://covers.openlibrary.org/b/isbn/\(isbn)-M.jpg") {
            url = isbnURL
        } else if let id = coverId, id != 0,
            let idURL = URL(string: "http://covers.openlibrary.org/b/id/\(id)-M.jpg") {
            url = idURL
        }
        
        print("URL: \(url?.absoluteURL)")
        return url
    }
    
    func getDetails() -> String {
        let authors = authorName.joined(separator: ", ")
        let year = (firstPublishYear != nil && firstPublishYear != 0) ? "\(firstPublishYear!)" : "Unknown"
        return "Authors: \(authors)\n"
            + "Year: \(year)\n"
            + "Has full text: \((hasFulltext == true) ? "Yes" : "No")"
    }
    
    func getDetailsURL() -> URL? {
        var url: URL? = nil
        if let isbn = isbn.first,
            let isbnURL = URL(string: "http://openlibrary.org/api/volumes/brief/isbn/\(isbn).json") {
            url = isbnURL
        } else if let lccn = lccn.first,
            let lccnURL = URL(string: "http://openlibrary.org/api/volumes/brief/lccn/\(lccn).json") {
            url = lccnURL
        } else if let oclc = oclc.first,
            let oclcURL = URL(string: "http://openlibrary.org/api/volumes/brief/oclc/\(oclc).json") {
            url = oclcURL
        }
        
        return url
    }
}
