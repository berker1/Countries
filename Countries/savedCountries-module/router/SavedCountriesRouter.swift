//
//  SavedCountriesRouter.swift
//  Countries
//
//  Created by Berker Koparal on 7.09.2022.
//

import Foundation

class SavedCountriesRouter : PresenterToRouterSavedCountriesProtocol{
    static func createModule(ref: SavedCountriesVC) {
        let presenter = SavedCountriesPresenter()
        //view
        ref.savedCountriesPresenterObject = presenter
        //presenter
        ref.savedCountriesPresenterObject?.savedCountriesInteractor = SavedCountriesInteractor()
        ref.savedCountriesPresenterObject?.savedCountriesView = ref
        //interactor
        ref.savedCountriesPresenterObject?.savedCountriesInteractor?.savedCountriesPresenter = presenter
    }
    
    
}


