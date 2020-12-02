//
//  ExchangeRateViewController.swift
//  CurrencyConverter
//
//  Created by Ashish on 02/12/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit

class ExchangeRateViewController: CurrencyBaseController {

    @IBOutlet weak var listView: UITableView!
    
    var currencyModel : CurrencyModel? {
        didSet {
            if let model = currencyModel {
                countryKeys = Array(model.quotes.keys).sorted(by: ({$0 < $1}))
            }
        }
    }
        
    var countryKeys : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = String(describing: CountryTableViewCell.self)
        let nib = UINib(nibName: name, bundle: nil)
        listView.register(nib, forCellReuseIdentifier: name)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ExchangeRateViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:CountryTableViewCell.self), for: indexPath) as? CountryTableViewCell
        if let quotes = currencyModel?.quotes {
            cell?.exchange(name: countryKeys[indexPath.row], source: currencyModel?.source ?? "USD",rate: String(format: "%.2f", quotes[countryKeys[indexPath.row]] ?? 0.0))
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryKeys.count
    }
}
