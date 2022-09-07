//
//  SavedCountriesCollectionViewCell.swift
//  Countries
//
//  Created by Berker Koparal on 7.09.2022.
//

import UIKit

class SavedCountriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelSavedCountryName: UILabel!
    @IBOutlet weak var buttonUnfollowCountry: UIButton!
    
    var cellProtocol:cellButtonSavedCountryProtocol?
    var indexPath:IndexPath?
    
    @IBAction func buttonUnfollowCountryAction(_ sender: Any) {
        cellProtocol?.buttonUnfollowCountryClicked(indexPath: indexPath!)
    }
}
