//
//  SearchViewController.swift
//  BooksSearchongDemo
//
//  Created by Ruslan Yupyn on 09.02.2020.
//  Copyright © 2020 Ruslan Yupyn. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var serchText: UITextField!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        print("\(serchText.text ?? "") was entered...")
    }
}

