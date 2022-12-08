//
//  CountryInfo.swift
//  Countries
//
//  Created by Bryce Hawkins on 11/30/22.
//

import Foundation
import UIKit

extension ViewController {
    
    func Network() {
        let urlString = "https://restcountries.com/v3.1/all"
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(json: data)
                    return
                }
            } else {
                DispatchQueue.main.async {
                    self.showError()
                }
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        do {
            let jsonCountries = try decoder.decode([Country].self, from: json)
            countries = jsonCountries
            searchedCountries = countries
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch let error {
            print(error)
        }
    }
         
    @objc func showError() {
         let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed. Please check your connection and try again", preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: "Ok", style: .default))
         present(ac, animated: true)
    }
}
