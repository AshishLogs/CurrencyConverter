//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Ashish on 28/11/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: CurrencyBaseController, CurrencyHelpers, CountryViewControllerDelegate {

    @IBOutlet weak var onboardingView: UIView!
    @IBOutlet weak var tapmeLbl: UILabel!
    @IBOutlet weak var keyboardContainerView: UIView!
    @IBOutlet weak var toBtn: UIButton!
    @IBOutlet weak var fromBtn: UIButton!
    @IBOutlet weak var exchangelabel: UILabel!
    
    @IBOutlet weak var toCurrencyTF: UITextField! {
        didSet {
            toCurrencyTF.paddingRL(10.0)
            toCurrencyTF.inputView()
            toCurrencyTF.layering(5.0, borderColor: Color.textfieldBackground)
        }
    }
    
    @IBOutlet weak var fromCurrencyTF: UITextField! {
        didSet {
            fromCurrencyTF.paddingRL(10.0)
            fromCurrencyTF.layering(5.0, borderColor: Color.textfieldBackground)
        }
    }
    
    var currentModel : SelectionCurrencyModel? {
        didSet {
            if let model = currentModel {
                let toName = String(format: "%@ %@", model.toFlag, model.to)
                toBtn.setTitle(toName, for: .normal)
                let fromName = String(format: "%@ %@", model.fromFlag, model.from)
                fromBtn.setTitle(fromName, for: .normal)
                fromCurrencyTF.text = ""
                toCurrencyTF.text = ""
                updateExchangeRate()
            }
        }
    }
    
    var dataSource : CurrencyDataSource = CurrencyDataSource()
    
    var viewModel : CurrencyViewModel {
        let viewmodel = CurrencyViewModel(datasource: dataSource)
        return viewmodel
    }
    
    var currencyModel : CurrencyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentModel = SelectionCurrencyModel(to: "USD", from: "INR")
        pulsate(view: tapmeLbl, repeatCount: .infinity)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {[weak self] in
            guard let self = self else { return }
            self.onboardingView.isHidden = true
        }
        
        dataSource.addAndNotify(observer: self) { [weak self](model) in
            guard let self = self else { return }
            self.currencyModel = model
            self.updateExchangeRate()
        }
        
        viewModel.fetchCurrenciesList()
        
    }
    
    func updateExchangeRate() {
        if let to = self.currentModel?.to ,let from = self.currentModel?.from, let source = self.currencyModel?.source, let quotes = self.currencyModel?.quotes {
            let toConversion = quotes[(source+to)] ?? 0.0
            let fromConversion = quotes[(source+from)] ?? 0.0
            let rate = (fromConversion / toConversion)
            DispatchQueue.main.async {
                self.exchangelabel.text = String(format: "Exchange Rate - %0.2f %@", rate, from)
            }
        }
    }
    
    func setCurrentCountrySelection(from: String) {
        if let model = currentModel {
            let to = model.to
            currentModel = SelectionCurrencyModel.init(to: to, from: from)
        }
    }
    
    func setCurrentCountrySelection(to: String) {
        if let model = currentModel {
            let from = model.from
            currentModel = SelectionCurrencyModel.init(to: to, from: from)
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
         return false
    }

    
    //MARK:- IBActions
    // convert button action
    @IBAction func convertCurrencyAction(_ sender: UIButton) {
        pulsate(view: sender)
        let formatter = NumberFormatter()
        if let text = toCurrencyTF.text {
            if let number = formatter.number(from: text) {
                let floatNumber = number.floatValue
                if let to = self.currentModel?.to ,let from = self.currentModel?.from, let source = self.currencyModel?.source, let quotes = self.currencyModel?.quotes {
                    let toConversion = quotes[(source+to)] ?? 0.0
                    let fromConversion = quotes[(source+from)] ?? 0.0
                    let rate = (fromConversion / toConversion) * Double(floatNumber)
                    DispatchQueue.main.async {
                        self.fromCurrencyTF.text = String(format: "%0.2f", rate)
                    }
                }
            }
        }
    }
    
    @IBAction func toAction(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CountryViewController.self)) as? CountryViewController else { return }
        vc.currencyModel = self.currencyModel
        vc.isToChannel = true
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func fromAction(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CountryViewController.self)) as? CountryViewController else { return }
        vc.currencyModel = self.currencyModel
        vc.isToChannel = false
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func exchangeRate(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: ExchangeRateViewController.self)) as? ExchangeRateViewController else { return }
        vc.currencyModel = self.currencyModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
//MARK:- Collection View Delegates
extension CurrencyConverterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyboardButtons().count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: KeyboardCell.self), for: indexPath) as? KeyboardCell
        cell?.wrapText(digits: keyboardButtons()[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = keyboardContainerView.bounds.width / 3.0
        let height = keyboardContainerView.bounds.height / 4.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let inputString = self.keyboardButtons()[indexPath.row]
        if indexPath.row == 11 {
            if !(toCurrencyTF.text?.isEmpty ?? false) {
                _ = toCurrencyTF.text?.removeLast()
                return
            }
            return
        }
        toCurrencyTF.text?.append(inputString)
    }
    
}

//MARK:- UICollectionView Cell

class KeyboardCell : UICollectionViewCell {
    
    @IBOutlet weak var digitsLabel: UILabel!
    
    func wrapText(digits: String) {
        digitsLabel.text = digits
    }
    
}

