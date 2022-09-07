//
//  HomePagePresenter.swift
//  Countries
//
//  Created by Berker Koparal on 6.09.2022.
//

import Foundation

class HomePagePresenter : ViewToPresenterHomePageProtocol {
    
    var homePageInteractor: PresenterToInteractorHomePageProtocol?
    var homePageView: PresenterToViewHomePageProtocol?
    
    func allCountries() {
        homePageInteractor?.getAllCountries()
    }
    
    func save(country: Countries) {
        homePageInteractor?.saveCountry(country: country)
    }
    
}

extension HomePagePresenter : InteractorToPresenterHomePageProtocol {
    func sendDataToPresenter(countriesList: Array<Countries>) {
        
        homePageView?.sendDataToView(countriesList: countriesList)
    }
    
    
}
