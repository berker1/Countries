//
//  DetailCardRouter.swift
//  Countries
//
//  Created by Berker Koparal on 6.09.2022.
//

import Foundation

class DetailCardRouter : PresenterToRouterDetailCardProtocol {
    static func createModule(ref: DetailCardVC) {
        let presenter = DetailCardPresenter()
        //view
        ref.detailCardPresenterObject = presenter
        //presenter
        ref.detailCardPresenterObject?.detailCardInteractor = DetailCardInteractor()
        ref.detailCardPresenterObject?.detailCardView = ref
        //interactor
        ref.detailCardPresenterObject?.detailCardInteractor?.detailCardPresenter = presenter
    }
}


