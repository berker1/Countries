//
//  AllCountriesCollectionViewCell.swift
//  Countries
//
//  Created by Berker Koparal on 7.09.2022.
//

import UIKit

class AllCountriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var buttonFollowCountry: UIButton!
    @IBOutlet weak var labelCountryName: UILabel!
    
    var cellProtocol:cellButtonHomePageProtocol?
    var indexPath:IndexPath?
    
    @IBAction func buttonFollowCountryAction(_ sender: Any) {
        cellProtocol?.buttonSaveCountryClicked(indexPath: indexPath!)
    }

}
