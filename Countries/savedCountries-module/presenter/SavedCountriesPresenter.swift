//
//  SavedCountriesPresenter.swift
//  Countries
//
//  Created by Berker Koparal on 7.09.2022.
//

import Foundation

class SavedCountriesPresenter : ViewToPresenterSavedCountriesProtocol {
    var savedCountriesInteractor: PresenterToInteractoravedCountriesProtocol?
    var savedCountriesView: PresenterToViewSavedCountriesProtocol?
    
    func allSavedCountries() {
        savedCountriesInteractor?.getAllSavedCountries()
    }
    
    func delete(country: Countries) {
        savedCountriesInteractor?.deleteCountry(country: country)
    }
    
    
}

extension SavedCountriesPresenter : InteractorToPresenterSavedCountriesProtocol {
    func sendDataToPresenter(countriesList: Array<Countries>) {
        savedCountriesView?.sendDataToView(countriesList: countriesList)
    }
    
    
}

