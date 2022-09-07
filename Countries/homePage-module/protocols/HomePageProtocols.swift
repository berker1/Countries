//
//  HomePageProtocols.swift
//  Countries
//
//  Created by Berker Koparal on 6.09.2022.
//

import Foundation

//main protocols
protocol ViewToPresenterHomePageProtocol{
    var homePageInteractor:PresenterToInteractorHomePageProtocol? {get set}
    var homePageView:PresenterToViewHomePageProtocol? {get set}
    
    func allCountries()
    func save(country:Countries)
}

protocol PresenterToInteractorHomePageProtocol {
    var homePagePresenter:InteractorToPresenterHomePageProtocol? {get set}
    
    func getAllCountries()
    func saveCountry(country:Countries)
}

//side Protocols
protocol InteractorToPresenterHomePageProtocol {
    func sendDataToPresenter(countriesList:Array<Countries>)
}

protocol PresenterToViewHomePageProtocol {
    func sendDataToView(countriesList:Array<Countries>)
    
}

//router
protocol PresenterToRouterHomePageProtocol {
    static func createModule(ref:HomePageVC)
}

protocol cellButtonHomePageProtocol {
    func buttonSaveCountryClicked(indexPath:IndexPath)
}
