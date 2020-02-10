//
//  SearchViewController.swift
//  BooksSearchongDemo
//
//  Created by Ruslan Yupyn on 09.02.2020.
//  Copyright © 2020 Ruslan Yupyn. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var serchText: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private var books = [Book]()
    private var count = 0
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        search(for: serchText.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
    }
    
    func search(for text: String) {
        if text.isEmpty {
            let alert = UIAlertController(title: "Search:", message: "Please input search text.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                DispatchQueue.main.async {
                    alert.dismiss(animated: true, completion: nil)
                    self.serchText.becomeFirstResponder()
                }
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        DispatchQueue.main.async {
            self.indicator.startAnimating()
            self.indicator.isHidden = false
            self.view.isUserInteractionEnabled = false
        }
        print("\(text) was entered...")
        let params = [
            "q" : text,
            "page" : 1
            ] as [String : Any]
        AF.request("http://openlibrary.org/search.json", method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(let JSONdata):
                let parsedObj = JSON(JSONdata)
                self.count = parsedObj["numFound"].intValue
                parsedObj["docs"].array?.forEach({ (bookJSON) in
                    let book = Book(json: bookJSON)
                    self.books.append(book)
                })
                if self.books.count > 0 {
                    self.loadNextScreenWithBooks()
                } else {
                    let alert = UIAlertController(title: "Search:", message: "There is no search result for string \"\(text)\"", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                        DispatchQueue.main.async {
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            case .failure(let err):
                let alert = UIAlertController(title: "Search error:", message: err.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                    DispatchQueue.main.async {
                        alert.dismiss(animated: true, completion: nil)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
            self.indicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func loadNextScreenWithBooks() {
        self.performSegue(withIdentifier: "SearchToBooklist", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        serchText.resignFirstResponder()
        search(for: serchText.text ?? "")
        return true
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! BooksListVC
        destinationVC.books = books
        destinationVC.searchText = serchText.text ?? ""
        DispatchQueue.main.async {
            self.serchText.text = ""
        }
        
    }
}

