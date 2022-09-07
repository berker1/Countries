//
//  Countries.swift
//  Countries
//
//  Created by Berker Koparal on 5.09.2022.
//

import Foundation

class Countries {
    
    var countryCode:String?
    var countryName:String?
    var countryFlag:String?
    var countryWikiCode:String?
    var countrySaved:Bool?
    
    init(countryCode:String, countryName: String, countryFlag: String, countryWikiCode: String, countrySaved:Bool) {
        self.countryCode = countryCode
        self.countryName = countryName
        self.countryFlag = countryFlag
        self.countryWikiCode = countryWikiCode
        self.countrySaved = countrySaved
    }
    
    init(countryCode: String, countryName: String, countrySaved:Bool) {
        self.countryCode = countryCode
        self.countryName = countryName
        self.countrySaved = countrySaved
    }
    
    init(countryCode: String){
        self.countryCode = countryCode
    }
}
