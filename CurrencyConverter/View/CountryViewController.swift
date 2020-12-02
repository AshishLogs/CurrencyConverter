//
//  CountryViewController.swift
//  CurrencyConverter
//
//  Created by Ashish on 28/11/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit

protocol CountryViewControllerDelegate : class {
    func setCurrentCountrySelection(to: String)
    func setCurrentCountrySelection(from: String)
}

class CountryViewController: CurrencyBaseController, CurrencyHelpers {
    
    @IBOutlet weak var searchCountry: UITextField!
    @IBOutlet weak var countryListView: UITableView!
    
    weak var delegate : CountryViewControllerDelegate?
    
    var currencyModel : CurrencyModel? {
        didSet {
            if let model = currencyModel {
                countryKeys = Array(model.quotes.keys).sorted(by: ({$0 < $1}))
            }
        }
    }
    
    var isToChannel : Bool = true
    
    var countryKeys : [String] = []
    
    var searchedKeys : [String] = [] {
        didSet {
            countryListView.reloadData()
        }
    }
    
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchField()
        // Do any additional setup after loading the view.
        let name = String(describing: CountryTableViewCell.self)
        let nib = UINib(nibName: name, bundle: nil)
        countryListView.register(nib, forCellReuseIdentifier: name)
    }
    
    private func setupSearchField() {
        searchCountry.delegate = self
        searchCountry.leftViewMode  = .always
        searchCountry.leftView      = UIView(frame: .init(x: 0.0, y: 0.0, width: 20.0, height: 10.0))
        searchCountry.rightViewMode = .always
        searchCountry.rightView     = UIView(frame: .init(x: 0.0, y: 0.0, width: 20.0, height: 10.0))
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:CountryTableViewCell.self), for: indexPath) as? CountryTableViewCell
        if isSearching {
            cell?.countryName(name: searchedKeys[indexPath.row], source: currencyModel?.source ?? "USD")
        } else {
            cell?.countryName(name: countryKeys[indexPath.row], source: currencyModel?.source ?? "USD")
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? searchedKeys.count : countryKeys.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = isSearching ? searchedKeys[indexPath.row] : countryKeys[indexPath.row]
        let source = currencyModel?.source ?? "USD"
        if isToChannel {
            self.delegate?.setCurrentCountrySelection(to: String(key.dropFirst(source.count)))
        } else {
            self.delegate?.setCurrentCountrySelection(from: String(key.dropFirst(source.count)))
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CountryViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            searching(text: updatedText)
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func searching(text: String) {
        let source = currencyModel?.source ?? ""
        searchedKeys = []
        isSearching = text.count > 0 ? true : false
        searchedKeys = countryKeys.filter({(item: String) -> Bool in
             let stringMatch = String(item.dropFirst(source.count)).lowercased().range(of: text.lowercased())
             return stringMatch != nil ? true : false
        })
    }
    
}
