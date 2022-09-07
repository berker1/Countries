//
//  SavedCountriesProtocols.swift
//  Countries
//
//  Created by Berker Koparal on 7.09.2022.
//

import Foundation

//main protocols
protocol ViewToPresenterSavedCountriesProtocol {
    var savedCountriesInteractor:PresenterToInteractoravedCountriesProtocol? {get set}
    var savedCountriesView:PresenterToViewSavedCountriesProtocol? {get set}
    
    func allSavedCountries()
    func delete(country:Countries)
}

protocol PresenterToInteractoravedCountriesProtocol {
    var savedCountriesPresenter:InteractorToPresenterSavedCountriesProtocol? {get set}
    
    func getAllSavedCountries()
    func deleteCountry(country:Countries)
}

//side protocols
protocol InteractorToPresenterSavedCountriesProtocol {
    func sendDataToPresenter(countriesList:Array<Countries>)
}

protocol PresenterToViewSavedCountriesProtocol {
    func sendDataToView(countriesList:Array<Countries>)
}

//router
protocol PresenterToRouterSavedCountriesProtocol {
    static func createModule(ref:SavedCountriesVC)
}

//button protocol
protocol cellButtonSavedCountryProtocol {
    func buttonUnfollowCountryClicked(indexPath:IndexPath)
}


