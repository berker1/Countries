//
//  ViewController.swift
//  Countries
//
//  Created by Berker Koparal on 5.09.2022.
//

import UIKit

class HomePageVC: UIViewController {

    @IBOutlet weak var allCountriesCollectionView: UICollectionView!
    
    var countriesList = [Countries]()
    
    var homePagePresenterObject:ViewToPresenterHomePageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        design.minimumInteritemSpacing = 20
        design.minimumLineSpacing = 20
        
        let widthCV = allCountriesCollectionView.frame.size.width
        let itemWidth = (widthCV - 40) / 1
        design.itemSize = CGSize(width: itemWidth, height: itemWidth * 0.15)
        allCountriesCollectionView.collectionViewLayout = design
        
        allCountriesCollectionView.delegate = self
        allCountriesCollectionView.dataSource = self
        
        HomePageRouter.createModule(ref: self)
        databaseCopy()
        
        let apperance = UITabBarAppearance()
        changeTabBarColor(itemAppearance: apperance.stackedLayoutAppearance)
        changeTabBarColor(itemAppearance: apperance.inlineLayoutAppearance)
        changeTabBarColor(itemAppearance: apperance.compactInlineLayoutAppearance)
        
        tabBarController?.tabBar.standardAppearance = apperance
        tabBarController?.tabBar.scrollEdgeAppearance = apperance
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        homePagePresenterObject?.allCountries()
    }
    
    func changeTabBarColor(itemAppearance:UITabBarItemAppearance){
        //chosen
        itemAppearance.selected.iconColor = UIColor.white
        
        //not chosen
        itemAppearance.normal.iconColor = UIColor.black
    }
    
    func databaseCopy(){
        let bundlePath = Bundle.main.path(forResource: "CountriesDB", ofType: ".sqlite")
        let destination = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let toCopyPath = URL(fileURLWithPath: destination).appendingPathComponent("CountriesDB.sqlite")
        let fm = FileManager.default
        if fm.fileExists(atPath: toCopyPath.path) {
            print("database already exist.")
        }else{
            do{
                try fm.copyItem(atPath: bundlePath!, toPath: toCopyPath.path)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailCard" {
            if let countryCode = sender as? String {
                let destinatedVC = segue.destination as! DetailCardVC
                destinatedVC.detailCountryCode = countryCode
            }
        }
    }
    

}


extension HomePageVC : PresenterToViewHomePageProtocol {
    
    func sendDataToView(countriesList: Array<Countries>) {
        self.countriesList = countriesList
        self.allCountriesCollectionView.reloadData()
    }
    
    
}

extension HomePageVC : UICollectionViewDelegate, UICollectionViewDataSource, cellButtonHomePageProtocol{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let country = countriesList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allCountriesCell", for: indexPath ) as! AllCountriesCollectionViewCell
        
        cell.labelCountryName.text = "\(country.countryName!)"
        //print("cell name: \(cell.labelCountryName.text!)")
        
        if country.countrySaved == true{
            cell.buttonFollowCountry.setImage(UIImage(named: "star_filled"), for: .normal)
        }else{
            cell.buttonFollowCountry.setImage(UIImage(named: "star_empty"), for: .normal)
        }
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        
        cell.cellProtocol = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let country = countriesList[indexPath.row]
        performSegue(withIdentifier: "toDetailCard", sender: country.countryCode)
    }
    
    func buttonSaveCountryClicked(indexPath: IndexPath) {
        let country = countriesList[indexPath.row]
        print("star clicked \(country.countryCode!)")
        homePagePresenterObject?.save(country: country)
    }
    
}
