//
//  DetailCardInteractor.swift
//  Countries
//
//  Created by Berker Koparal on 6.09.2022.
//

import Foundation

class DetailCardInteractor : PresenterToInteractorDetailCardProtocol {
    
    var detailCardPresenter: InteractorToPresenterDetailCardProtocol?
    
    var homePagePresenter: InteractorToPresenterHomePageProtocol?
    
    let db:FMDatabase?
    
    init(){
        let destination = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let toCopyPath = URL(fileURLWithPath: destination).appendingPathComponent("CountriesDB.sqlite")
        db = FMDatabase(path: toCopyPath.path)
        
    }
    
    func detailedCountry(countryCode: String) {
        getDetailedCountry(code: countryCode)
    }
    
    func getDetailedCountry(code:String){
            
        var countryDetailed:Countries?
            
            let headers = [
                "X-RapidAPI-Key": "145bdfdb92mshb4fc40b407d5101p1e31b7jsn68fd50b2e564",
                "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
            ]
            let url = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(code)"
        
            let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
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
                            print("json:\(json)")
                            
                            if let data2 = json["data"] as? NSDictionary{
                                if let flag = data2["flagImageUri"] as? String,let wiki = data2["wikiDataId"] as? String, let nameCountry = data2["name"] as? String, let countryCode = data2["code"] as? String{
                                    var countrySaved:Bool?
                                    print("flag \(flag)")
                                    print("name: \(nameCountry)")
                                    print("wiki \(wiki)")
                                    
                                    if self.isCountrySaved(countryCode: countryCode) == true{
                                        countrySaved = true
                                    }else{
                                        countrySaved = false
                                    }
                                    
                                    countryDetailed = Countries(countryCode: countryCode ,countryName: nameCountry, countryFlag: flag, countryWikiCode: wiki, countrySaved: countrySaved!)
                                }
                            }
                            if countryDetailed == nil {
                                countryDetailed = Countries(countryCode: "Country Code", countryName: "Country Name", countryFlag: "none", countryWikiCode: "none", countrySaved: false)
                            }
                        
                            DispatchQueue.main.sync {
                                    self.detailCardPresenter?.sendDataToPresenter(detailedCountry: countryDetailed!)
                            }
                            
                        }catch{
                            print("getDetailedCountry DetailCardInteractor something wrong")
                        }
                }
            })

            dataTask.resume()
        
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

