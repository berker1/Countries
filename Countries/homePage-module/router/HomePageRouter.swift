//
//  HomePageRouter.swift
//  Countries
//
//  Created by Berker Koparal on 6.09.2022.
//

import Foundation

class HomePageRouter : PresenterToRouterHomePageProtocol {
    static func createModule(ref: HomePageVC) {
        let presenter = HomePagePresenter()
        //View
        ref.homePagePresenterObject = presenter
        //Presenter
        ref.homePagePresenterObject?.homePageInteractor = HomePageInteractor()
        ref.homePagePresenterObject?.homePageView = ref
        //Interactor
        ref.homePagePresenterObject?.homePageInteractor?.homePagePresenter = presenter
    }
    
    
}
