//
//  ViewController.swift
//  Countries
//
//  Created by Bryce Hawkins on 11/30/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()
    var searchedCountries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Country List"
        
        Network() //CountryInfo.swift extends view controller and Network is a background API call function.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
    }
    
    @objc func refresh() {
        searchedCountries = countries
        tableView.reloadData()
    }
    
    @objc func search() {
        let ac = UIAlertController(title: "Search countries", message: "Enter a country", preferredStyle: .alert)
        ac.addTextField()
       
        let searchAction = UIAlertAction(title: "Search", style: .default) {
            [weak self, weak ac] action in
            guard let Key = ac?.textFields?[0].text else { return }
            self?.submit(Key)
        }
        ac.addAction(searchAction)
        present(ac, animated: true)
    }
    
    func submit(_ Key: String) {
        if !(Key.isEmpty) {
        searchedCountries.removeAll()
            for country in countries {
                if country.name.common.lowercased().contains(Key.lowercased()) || country.name.official.lowercased().contains(Key.lowercased()) {
                    searchedCountries.append(country)
                }
            }
        tableView.reloadData()
        } else {
            let ac = UIAlertController(title: nil, message: "Please enter a country to search for", preferredStyle: .alert)
            let errorAction = UIAlertAction(title: "Ok", style: .default)
            ac.addAction(errorAction)
            present(ac, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedCountries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let country = searchedCountries[indexPath.row]
        cell.textLabel?.text = country.name.common
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.country = searchedCountries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}



