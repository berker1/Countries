//
//  DetailCardProtocols.swift
//  Countries
//
//  Created by Berker Koparal on 6.09.2022.
//

import Foundation

//main Protocols
protocol ViewToPresenterDetailCardProtocol{
    var detailCardInteractor:PresenterToInteractorDetailCardProtocol? {get set}
    var detailCardView:PresenterToViewDetailCardProtocol? {get set}
    
    func showDetailedCountry(countryCode:String)
}

protocol PresenterToInteractorDetailCardProtocol{
    var detailCardPresenter:InteractorToPresenterDetailCardProtocol? {get set}
    
    func detailedCountry(countryCode:String)
}


//side Protocols
protocol InteractorToPresenterDetailCardProtocol{
    func sendDataToPresenter(detailedCountry:Countries)
}

protocol PresenterToViewDetailCardProtocol{
    func sendDataToView(detailedCountry:Countries)
}

//router
protocol PresenterToRouterDetailCardProtocol{
    static func createModule(ref:DetailCardVC)
}


