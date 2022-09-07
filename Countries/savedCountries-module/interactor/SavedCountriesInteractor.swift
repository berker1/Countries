//
//  SavedCountriesInteractor.swift
//  Countries
//
//  Created by Berker Koparal on 7.09.2022.
//

import Foundation

class SavedCountriesInteractor : PresenterToInteractoravedCountriesProtocol {
    var savedCountriesPresenter: InteractorToPresenterSavedCountriesProtocol?
    
    let db:FMDatabase?
    
    init(){
        let destination = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let toCopyPath = URL(fileURLWithPath: destination).appendingPathComponent("CountriesDB.sqlite")
        db = FMDatabase(path: toCopyPath.path)
        
    }
    
    func getAllSavedCountries() {
        savedCountriesFromDB()
    }
    
    func deleteCountry(country: Countries) {
        unfollowSelectedCountry(selectedCountry: country)
    }
    
    func savedCountriesFromDB(){
            
        var listCountries = [Countries]()
         
        db?.open()
        
        do{
            let q = try db!.executeQuery("SELECT * FROM countries", values: nil)
            
            while q.next() {
                let country = Countries(countryCode: q.string(forColumn: "country_code"), countryName: q.string(forColumn: "country_name"), countrySaved: true)
                listCountries.append(country)
            }
            
            savedCountriesPresenter?.sendDataToPresenter(countriesList: listCountries)
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
          
        }
    
    func unfollowSelectedCountry(selectedCountry:Countries){
        
        var countryCode:String?
        countryCode = selectedCountry.countryCode
        
        db?.open()
        
        do{
            //print("buton tıklandı \(countryCode!), \(selectedCountry.countrySaved!)")
            
                try db!.executeUpdate("delete from countries where country_code = ?", values: [countryCode!])
            savedCountriesFromDB()
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func isCountrySaved(countryCode:String) -> Bool{
        var isSaved = false
        db?.open()
        
        do{
            let q = try db!.executeQuery("SELECT * FROM countries where country_code = ?", values: [countryCode])
            
            while q.next(){
                let country_code = q.string(forColumn: "country_code")
                if ((country_code?.isEmpty) == nil) {
                    isSaved = false
                }else {
                    isSaved = true
                }
            }
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        print("isSaved: \(isSaved)")
        return isSaved
    }
    
}
