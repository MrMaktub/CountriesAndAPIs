//
//  Country.swift
//  Countries
//
//  Created by Bryce Hawkins on 11/30/22.
//

import Foundation

struct Country: Codable {
    let name: Name
    let capital: [String]?
    let region: String
    let subRegion: String?
    let languages: [String: String]?
    let population: Int
    let flags: Flag
    let currencies: [String : [String: String]?]?
    
    init(name: Name, capital: [String]?, region: String, subRegion: String?, languages: [String : String]?, population: Int, flags: Flag, currencies: [String: [String: String]?]?) {
        self.name = name
        self.capital = capital
        self.region = region
        self.subRegion = subRegion
        self.languages = languages
        self.population = population
        self.flags = flags
        self.currencies = currencies
    }
}

struct Name: Codable {
    let common: String
    let official: String
}

struct Flag: Codable {
    let svg: String
    let png: String
}





