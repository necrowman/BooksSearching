//
//  BookCell.swift
//  BooksSearchongDemo
//
//  Created by Ruslan Yupyn on 10.02.2020.
//  Copyright © 2020 Ruslan Yupyn. All rights reserved.
//

import UIKit
import Nuke
import SnapKit

class BookCell: UITableViewCell {
    
    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populate(with book: Book) {
        self.bookImageView.clipsToBounds = true
        self.bookImageView.contentMode = .scaleAspectFill
        self.bookImageView.backgroundColor = .gray
        self.bookImageView.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8).priority(900)
        }
        
        if let url = book.coverURL() {
            loadImg(for: url)
        } else if let isbn = book.isbn.last,
            let url = URL(string: "http://covers.openlibrary.org/b/isbn/\(isbn)-M.jpg") {
            loadImg(for: url)
        }
        
        else {
            self.bookImageView.image = #imageLiteral(resourceName: "bg_img")
        }
        
        self.titleLabel.text = book.title
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.bookImageView.snp.right).offset(8)
            make.top.equalTo(self.bookImageView.snp.top)
            make.right.equalToSuperview().offset(-16)
        }
        
        self.detailsLabel.text = book.getDetails()
        self.detailsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.titleLabel.snp.leading)
            make.trailing.equalTo(self.titleLabel.snp.trailing)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
        }
    }
    
    func loadImg(for url: URL) {
        let options = ImageLoadingOptions(
            placeholder: #imageLiteral(resourceName: "bg_img"),
            transition: .fadeIn(duration: 0.1)
        )
        Nuke.loadImage(with: url, options: options, into: self.bookImageView)
    }
    
    
}
