//
//  CurrencyHelpers.swift
//  CurrencyConverter
//
//  Created by Ashish on 30/11/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit

protocol CurrencyHelpers {
}

extension CurrencyHelpers {
    func keyboardButtons() -> [String] {
        let keyboardButtons : [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".", "⌫"]
        return keyboardButtons
    }
    
    func pulsate(view: UIView, repeatCount: CGFloat = 1) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = Float(repeatCount)
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        view.layer.add(pulse, forKey: nil)
    }
    
    func flag(country:String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in country.utf16 {
            if let scalar = UnicodeScalar(base + Int(i)) {
                usv.append(scalar)
            }
        }
        return String(usv)
    }
    
    func countries(currencyCode: String) -> String {
        return [
        "AED" : "United Arab Emirates",
        "AFN" : "Afghanistan",
        "ALL" : "Albania",
        "AMD" : "Armenia",
        "ANG" : "Netherlands Antilles",
        "AOA" : "Angola",
        "ARS" : "Argentina",
        "AUD" : "Australia, Australian Antarctic Territory, Christmas Island, Cocos (Keeling) Islands, Heard and McDonald Islands, Kiribati, Nauru, Norfolk Island, Tuvalu",
        "AWG" : "Aruba",
        "AZN" : "Azerbaijan",
        "BAM" : "Bosnia and Herzegovina",
        "BBD" : "Barbados",
        "BDT" : "Bangladesh",
        "BGN" : "Bulgaria",
        "BHD" : "Bahrain",
        "BIF" : "Burundi",
        "BMD" : "Bermuda",
        "BND" : "Brunei",
        "BOB" : "Bolivia",
        "BOV" : "Bolivia",
        "BRL" : "Brazil",
        "BSD" : "Bahamas",
        "BTN" : "Bhutan",
        "BWP" : "Botswana",
        "BYR" : "Belarus",
        "BZD" : "Belize",
        "CAD" : "Canada",
        "CDF" : "Democratic Republic of Congo",
        "CHE" : "Switzerland",
        "CHF" : "Switzerland, Liechtenstein",
        "CHW" : "Switzerland",
        "CLF" : "Chile",
        "CLP" : "Chile",
        "CNY" : "Mainland China",
        "COP" : "Colombia",
        "COU" : "Colombia",
        "CRC" : "Costa Rica",
        "CUP" : "Cuba",
        "CVE" : "Cape Verde",
        "CYP" : "Cyprus",
        "CZK" : "Czech Republic",
        "DJF" : "Djibouti",
        "DKK" : "Denmark, Faroe Islands, Greenland",
        "DOP" : "Dominican Republic",
        "DZD" : "Algeria",
        "EEK" : "Estonia",
        "EGP" : "Egypt",
        "ERN" : "Eritrea",
        "ETB" : "Ethiopia",
        "EUR" : "European Union, see eurozone",
        "FJD" : "Fiji",
        "FKP" : "Falkland Islands",
        "GBP" : "United Kingdom",
        "GEL" : "Georgia",
        "GHS" : "Ghana",
        "GIP" : "Gibraltar",
        "GMD" : "Gambia",
        "GNF" : "Guinea",
        "GTQ" : "Guatemala",
        "GYD" : "Guyana",
        "HKD" : "Hong Kong Special Administrative Region",
        "HNL" : "Honduras",
        "HRK" : "Croatia",
        "HTG" : "Haiti",
        "HUF" : "Hungary",
        "IDR" : "Indonesia",
        "ILS" : "Israel",
        "INR" : "Bhutan, India",
        "IQD" : "Iraq",
        "IRR" : "Iran",
        "ISK" : "Iceland",
        "JMD" : "Jamaica",
        "JOD" : "Jordan",
        "JPY" : "Japan",
        "KES" : "Kenya",
        "KGS" : "Kyrgyzstan",
        "KHR" : "Cambodia",
        "KMF" : "Comoros",
        "KPW" : "North Korea",
        "KRW" : "South Korea",
        "KWD" : "Kuwait",
        "KYD" : "Cayman Islands",
        "KZT" : "Kazakhstan",
        "LAK" : "Laos",
        "LBP" : "Lebanon",
        "LKR" : "Sri Lanka",
        "LRD" : "Liberia",
        "LSL" : "Lesotho",
        "LTL" : "Lithuania",
        "LVL" : "Latvia",
        "LYD" : "Libya",
        "MAD" : "Morocco, Western Sahara",
        "MDL" : "Moldova",
        "MGA" : "Madagascar",
        "MKD" : "Former Yugoslav Republic of Macedonia",
        "MMK" : "Myanmar",
        "MNT" : "Mongolia",
        "MOP" : "Macau Special Administrative Region",
        "MRO" : "Mauritania",
        "MTL" : "Malta",
        "MUR" : "Mauritius",
        "MVR" : "Maldives",
        "MWK" : "Malawi",
        "MXN" : "Mexico",
        "MXV" : "Mexico",
        "MYR" : "Malaysia",
        "MZN" : "Mozambique",
        "NAD" : "Namibia",
        "NGN" : "Nigeria",
        "NIO" : "Nicaragua",
        "NOK" : "Norway",
        "NPR" : "Nepal",
        "NZD" : "Cook Islands, New Zealand, Niue, Pitcairn, Tokelau",
        "OMR" : "Oman",
        "PAB" : "Panama",
        "PEN" : "Peru",
        "PGK" : "Papua New Guinea",
        "PHP" : "Philippines",
        "PKR" : "Pakistan",
        "PLN" : "Poland",
        "PYG" : "Paraguay",
        "QAR" : "Qatar",
        "RON" : "Romania",
        "RSD" : "Serbia",
        "RUB" : "Russia, Abkhazia, South Ossetia",
        "RWF" : "Rwanda",
        "SAR" : "Saudi Arabia",
        "SBD" : "Solomon Islands",
        "SCR" : "Seychelles",
        "SDG" : "Sudan",
        "SEK" : "Sweden",
        "SGD" : "Singapore",
        "SHP" : "Saint Helena",
        "SKK" : "Slovakia",
        "SLL" : "Sierra Leone",
        "SOS" : "Somalia",
        "SRD" : "Suriname",
        "STD" : "São Tomé and Príncipe",
        "SYP" : "Syria",
        "SZL" : "Swaziland",
        "THB" : "Thailand",
        "TJS" : "Tajikistan",
        "TMM" : "Turkmenistan",
        "TND" : "Tunisia",
        "TOP" : "Tonga",
        "TRY" : "Turkey",
        "TTD" : "Trinidad and Tobago",
        "TWD" : "Taiwan and other islands that are under the effective control of the Republic of China (ROC)",
        "TZS" : "Tanzania",
        "UAH" : "Ukraine",
        "UGX" : "Uganda",
        "USD" : "American Samoa, British Indian Ocean Territory, Ecuador, El Salvador, Guam, Haiti, Marshall Islands, Micronesia, Northern Mariana Islands, Palau, Panama, Puerto Rico, East Timor, Turks and Caicos Islands, United States, Virgin Islands",
        "USN" : "United States",
        "USS" : "United States",
        "UYU" : "Uruguay",
        "UZS" : "Uzbekistan",
        "VEB" : "Venezuela",
        "VND" : "Vietnam",
        "VUV" : "Vanuatu",
        "WST" : "Samoa",
        "XAF" : "Cameroon, Central African Republic, Congo, Chad, Equatorial Guinea, Gabon",
        "XAG" : "",
        "XAU" : "",
        "XBA" : "",
        "XBB" : "",
        "XBC" : "",
        "XBD" : "",
        "XCD" : "Anguilla, Antigua and Barbuda, Dominica, Grenada, Montserrat, Saint Kitts and Nevis, Saint Lucia, Saint Vincent and the Grenadines",
        "XDR" : "International Monetary Fund",
        "XFO" : "Bank for International Settlements",
        "XFU" : "International Union of Railways",
        "XOF" : "Benin, Burkina Faso, Côte d'Ivoire, Guinea-Bissau, Mali, Niger, Senegal, Togo",
        "XPD" : "",
        "XPF" : "French Polynesia, New Caledonia, Wallis and Futuna",
        "XPT" : "",
        "XTS" : "",
        "XXX" : "",
        "YER" : "Yemen",
        "ZAR" : "South Africa",
        "ZMK" : "Zambia",
        "ZWD" : "Zimbabwe"][currencyCode] ?? ""
    }

}
