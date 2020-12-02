//
//  CountryTableViewCell.swift
//  CurrencyConverter
//
//  Created by Ashish on 02/10/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell, CurrencyHelpers {

    @IBOutlet weak var countryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func countryName(name: String, source:String) {
        let formatted = String(name.dropFirst(source.count))
        self.countryName.text = String.init(format: "%@ %@ - %@", flag(country: String(formatted.dropLast())), formatted, countries(currencyCode: formatted))
    }
    
    func exchange(name: String, source:String,rate: String) {
        let formatted = String(name.dropFirst(source.count))
        self.countryName.text = String.init(format: "%@ %@ -> Exchange Rate: %@", flag(country: String(formatted.dropLast())), formatted, rate)
    }

    
}
