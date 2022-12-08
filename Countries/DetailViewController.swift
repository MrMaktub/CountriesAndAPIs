//
//  DetailViewController.swift
//  Countries
//
//  Created by Bryce Hawkins on 12/3/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var infoTableView: UITableView!
        
    @IBOutlet var flagImage: UIImageView!
    
    var country: Country!
    var countryArr = [Int: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = country.name.official
        flagImage.loadFrom(URLAddress: country.flags.png)
        // Do any additional setup after loading the view.
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        if let url = URL(string: URLAddress) {
            
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let imageData = data else { return }
            
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
        }.resume()
        }
    }
}
    
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = infoTableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        if !(country.region.isEmpty) {
            countryArr[3] = "Region: \(country.region)"
        }
        if country.capital?.count != 0 {
            countryArr[2] = "Capital: \(String(describing: country.capital![0]))"
        }
        if !(country.name.common.isEmpty) {
            countryArr[0] = "Common Name: \(country.name.common)"
        }
        if !(country.name.official.isEmpty) {
            countryArr[1] = "Official Name: \(country.name.official)"
        }
        if !((country.subRegion?.isEmpty) == nil) {
            countryArr[4] = "Subregion: \(String(describing: country.subRegion))"
        } else {
            countryArr[4] = "Subregion: NA"
        }
        if !((country.languages?.isEmpty) == nil) {
            countryArr[5] = "Languages: \(String(describing: country.languages!.values.formatted()))"
        }
        if country.population != 0 {
            countryArr[6] = "Population: \(String(describing: country.population))"
        }
        if !((country.currencies?.isEmpty) == nil) {
            countryArr[7] = "Currencies: \(String(describing: country.currencies!.values))"
            //How do I get this value to show in the simulator as a string and not an optional array?
        }
        cell.backgroundColor = .white
        cell.textLabel?.text = countryArr[indexPath.row]
        return cell
    }
    
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

