//
//  DetailCardVC.swift
//  Countries
//
//  Created by Berker Koparal on 5.09.2022.
//

import UIKit
import WebKit
import SafariServices

class DetailCardVC: UIViewController {

    @IBOutlet weak var imgCountryFlag: WKWebView!
    @IBOutlet weak var buttonMoreInfo: UIButton!
    @IBOutlet weak var imageCountryFlag: UIImageView!
    @IBOutlet weak var labelCountryCode: UILabel!
    
    let wikiURL = "https://www.wikidata.org/wiki/"
    
    var detailCountryCode:String?
    var selectedCountry:Countries?
    
    var detailCardPresenterObject:ViewToPresenterDetailCardProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailCardPresenterObject?.showDetailedCountry(countryCode: detailCountryCode!)
        
        DetailCardRouter.createModule(ref: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailCardPresenterObject?.showDetailedCountry(countryCode: detailCountryCode!)
    }
    
    
    @IBAction func buttonMoreInfoAction(_ sender: Any) {
        
        let countryWikiCode = self.selectedCountry!.countryWikiCode
        let wikipediaURL = URL(string: wikiURL + countryWikiCode!)
        let vc = SFSafariViewController(url: wikipediaURL!)
        present(vc, animated: true)
        
    }

}

extension DetailCardVC : PresenterToViewDetailCardProtocol {
    func sendDataToView(detailedCountry: Countries) {
        self.selectedCountry = detailedCountry
        
        let flagURL = URL(string: (selectedCountry?.countryFlag)!)
        imgCountryFlag.load(URLRequest(url: flagURL!))
        
        navigationItem.title = detailedCountry.countryName
        
        if selectedCountry?.countrySaved == true {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .done, target: self, action: nil)
        }else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: self, action: nil)
        }
        
        labelCountryCode.text = selectedCountry?.countryCode
    }
    
    
}
