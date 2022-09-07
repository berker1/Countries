//
//  HomePageInteractor.swift
//  Countries
//
//  Created by Berker Koparal on 6.09.2022.
//

import Foundation

class HomePageInteractor : PresenterToInteractorHomePageProtocol {
    
    var homePagePresenter: InteractorToPresenterHomePageProtocol?
    
    let db:FMDatabase?
    
    init(){
        let destination = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let toCopyPath = URL(fileURLWithPath: destination).appendingPathComponent("CountriesDB.sqlite")
        db = FMDatabase(path: toCopyPath.path)
        
    }
    
    func getAllCountries() {
        countriesFromApi()
    }
    
    func saveCountry(country: Countries) {
        saveSelectedCountry(selectedCountry: country)
    }
    
    func countriesFromApi(){
            
            var listCountries = [Countries]()
            
            let headers = [
                "X-RapidAPI-Key": "145bdfdb92mshb4fc40b407d5101p1e31b7jsn68fd50b2e564",
                "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
            ]

            let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    let httpResponse = response as? HTTPURLResponse
                        do{
                            let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            //print("json:\(json)")
                            //print("type ne: \(type(of: json))")
                            
                            if let data = json["data"] as? NSArray {
                                print("let data is NSArray")
                                
                                let countriesLength = data.count
                                var countrySaved:Bool?
                                
                                for i in 0...countriesLength-1 {
                                    let newCountry = data[i] as? [String:Any]
                                    let countryName = newCountry!["name"]  as! String
                                    let countryCode = newCountry!["code"]  as! String
                                    
                                    if self.isCountrySaved(countryCode: countryCode) == true{
                                        countrySaved = true
                                    }else{
                                        countrySaved = false
                                    }
                                    print(countrySaved!)
                                    let country = Countries(countryCode: countryCode, countryName: countryName, countrySaved: countrySaved!)
                                    print("country: \(country.countryName!)")
                                    listCountries.append(country)
                                }
                                
                            }else{
                                print("let is NOt NSArray")
                            }
                            DispatchQueue.main.sync {
                                self.homePagePresenter?.sendDataToPresenter(countriesList: listCountries)
                            }
                            
                        }catch{
                            print("countriesFromApi homePageInteractor something wrong")
                        }
                }
            })

            dataTask.resume()
        }
    
    func saveSelectedCountry(selectedCountry:Countries){
        
        var countryCode:String?
        countryCode = selectedCountry.countryCode
        
        db?.open()
        
        do{
            //print("button clicked \(countryCode!), \(selectedCountry.countrySaved)")
            if selectedCountry.countrySaved == true{
                try db!.executeUpdate("delete from countries where country_code = ?", values: [countryCode!])
    
            }else{
                print("country kayıtlı degil \(countryCode!), \(selectedCountry.countrySaved!)")
                try db!.executeUpdate("insert into countries (country_code, country_saved, country_name) values (?,?,?)", values: [countryCode!, 1, selectedCountry.countryName!])
            }
            
            countriesFromApi()
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
