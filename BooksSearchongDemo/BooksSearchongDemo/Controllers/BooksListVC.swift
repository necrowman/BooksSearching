//
//  BooksListVC.swift
//  BooksSearchongDemo
//
//  Created by Ruslan Yupyn on 09.02.2020.
//  Copyright © 2020 Ruslan Yupyn. All rights reserved.
//

import UIKit

class BooksListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var booksTableView: UITableView!
    
    var searchText: String!
    var books: [Book] = []
    private var selectedItem: Book!
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
        title = searchText
        booksTableView.dataSource = self
        booksTableView.delegate = self
    }
    
    // table data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        let book = books[indexPath.row]
        DispatchQueue.main.async {
            cell.populate(with: book)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = books[indexPath.row]
        self.performSegue(withIdentifier: "BookListToView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! BookViewVC
        destinationVC.book = self.selectedItem
    }
}
