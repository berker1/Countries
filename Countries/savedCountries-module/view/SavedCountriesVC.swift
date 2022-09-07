//
//  SavedCountriesVC.swift
//  Countries
//
//  Created by Berker Koparal on 5.09.2022.
//

import UIKit

class SavedCountriesVC: UIViewController {

    @IBOutlet weak var savedCountriesCollectionView: UICollectionView!
    
    var countriesList = [Countries]()
    
    var savedCountriesPresenterObject:ViewToPresenterSavedCountriesProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collection view cell design
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20)
        design.minimumInteritemSpacing = 20
        design.minimumLineSpacing = 20
        
        let widthCV = savedCountriesCollectionView.frame.size.width
        let itemWidth = (widthCV - 40) / 1
        design.itemSize = CGSize(width: itemWidth, height: itemWidth * 0.15)
        savedCountriesCollectionView.collectionViewLayout = design
        
        savedCountriesCollectionView.delegate = self
        savedCountriesCollectionView.dataSource = self
        
        SavedCountriesRouter.createModule(ref: self)
        databaseCopy()
        
        //navigaton bar leftButton text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedCountriesPresenterObject?.allSavedCountries()
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
        if segue.identifier == "toDetailCardFromSaved" {
            if let countryCode = sender as? String {
                let destinatedVC = segue.destination as! DetailCardVC
                destinatedVC.detailCountryCode = countryCode
            }
        }
    }

}

extension SavedCountriesVC : PresenterToViewSavedCountriesProtocol{
    func sendDataToView(countriesList: Array<Countries>) {
        self.countriesList = countriesList
        self.savedCountriesCollectionView.reloadData()
    }
    
    
}


extension SavedCountriesVC : UICollectionViewDelegate, UICollectionViewDataSource, cellButtonSavedCountryProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let country = countriesList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedCountriesCell", for: indexPath ) as! SavedCountriesCollectionViewCell
        
        cell.labelSavedCountryName.text = "\(country.countryName!)"
        print("cell name: \(cell.labelSavedCountryName.text!)")
        
        cell.buttonUnfollowCountry.setImage(UIImage(named: "star_filled"), for: .normal)
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        
        cell.cellProtocol = self
        cell.indexPath = indexPath
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let country = countriesList[indexPath.row]
        performSegue(withIdentifier: "toDetailCardFromSaved", sender: country.countryCode)
    }
    
    func buttonUnfollowCountryClicked(indexPath: IndexPath) {
        let country = countriesList[indexPath.row]
        savedCountriesPresenterObject?.delete(country: country)
    }
}

