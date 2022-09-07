//
//  DetailCardPresenter.swift
//  Countries
//
//  Created by Berker Koparal on 6.09.2022.
//

import Foundation

class DetailCardPresenter : ViewToPresenterDetailCardProtocol {
    
    var detailCardInteractor: PresenterToInteractorDetailCardProtocol?
    var detailCardView: PresenterToViewDetailCardProtocol?
    
    func showDetailedCountry(countryCode: String) {
        detailCardInteractor?.detailedCountry(countryCode: countryCode)
    }

}

extension DetailCardPresenter : InteractorToPresenterDetailCardProtocol {
    func sendDataToPresenter(detailedCountry: Countries) {
        detailCardView?.sendDataToView(detailedCountry: detailedCountry)
    }
    
    
}

