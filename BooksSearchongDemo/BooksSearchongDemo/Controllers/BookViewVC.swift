//
//  BookViewVC.swift
//  BooksSearchongDemo
//
//  Created by Ruslan Yupyn on 10.02.2020.
//  Copyright © 2020 Ruslan Yupyn. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class BookViewVC: UIViewController, WKNavigationDelegate {
    
    var book: Book!
    
    @IBOutlet weak var detailsWebView: WKWebView!
    @IBOutlet weak var progress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsWebView.navigationDelegate = self
        detailsWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        if let detailsURL = book.getDetailsURL() {
            print("detailsURL \(detailsURL)")
            AF.request(detailsURL, method: .get).responseJSON { response in
                switch response.result {
                case .success(let JSONdata):
                    
                    guard let parsedObj = JSON(JSONdata).dictionary else {
                        self.parsingDetailsError()
                        return
                    }
                    
                    guard let records = parsedObj["records"]?.dictionary else {
                        self.parsingDetailsError()
                        return
                    }
                    
                    guard let key = records.keys.first else {
                        self.parsingDetailsError()
                        return
                    }
                    
                    guard let recordDict = records[key]?.dictionary else {
                        self.parsingDetailsError()
                        return
                    }
                    guard let recordURLString = recordDict["recordURL"]?.string else {
                        self.parsingDetailsError()
                        return
                    }
                    guard let url = URL(string: recordURLString) else {
                        self.parsingDetailsError()
                        return
                    }
                    
                    print("url \(url)")
                    let request = URLRequest(url: url)
                    DispatchQueue.main.async {
                        self.detailsWebView.load(request)
                    }
                case .failure(let err):
                let alert = UIAlertController(title: "Book details loading error:", message: err.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                    DispatchQueue.main.async {
                        alert.dismiss(animated: true, completion: nil)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
    
    func parsingDetailsError() {
        let alert = UIAlertController(title: "Book details loading error:", message: "Something went wrong on parsing book info!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            DispatchQueue.main.async {
                alert.dismiss(animated: true, completion: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
            if (keyPath == "estimatedProgress") { // listen to changes and updated view
                progress.isHidden = detailsWebView.estimatedProgress == 1
                progress.setProgress(Float(detailsWebView.estimatedProgress), animated: false)
            }
    }
}
