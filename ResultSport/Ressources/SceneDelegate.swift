//
//  SceneDelegate.swift
//  Sport
//
//  Created by Samy Boussair on 26/07/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let competitionRouter = CompetitionRouter()
        let competitionInteractor = CompetitionInteractor(router: competitionRouter)
        let competitionPresenter = CompetitionPresenter(interactor: competitionInteractor)
        let competitionSportModule = CompetitionModule(interactor: competitionInteractor,
                                            presenter: competitionPresenter,
                                            router: competitionRouter)
        
        let gameRouter = GameRouter()
        let gameInteractor = GameInteractor(router: gameRouter)
        let gamePresenter = GamePresenter(interactor: gameInteractor)
        let gameModule = GameModule(interactor: gameInteractor,
                                    presenter: gamePresenter,
                                    router: gameRouter)
        
        let standingRouter = StandingRouter()
        let standingInteractor = StandingInteractor(router: standingRouter)
        let standingPresenter = StandingPresenter(interactor: standingInteractor)
        let standingModule = StandingModule(interactor: standingInteractor,
                                            presenter: standingPresenter,
                                            router: standingRouter)

        let gameDetailsRouter = GameDetailsRouter()
        let gameDetailsInteractor = GameDetailsInteractor(router: gameDetailsRouter)
        let gameDetailsPresenter = GameDetailsPresenter(interactor: gameDetailsInteractor)
        let gameDetailsModule = GameDetailsModule(interactor: gameDetailsInteractor,
                                            presenter: gameDetailsPresenter,
                                            router: gameDetailsRouter)
        
        let tabBarController = TabBarController()
        tabBarController.viewControllerSearch = gameModule.viewController
        tabBarController.viewControllerCompetiton = competitionSportModule.viewController
        guard let standingViewController = standingModule.viewController as? StandingViewController else { return }
        competitionRouter.injectStandingViewController(viewController: standingViewController)
        guard let gameDetailsViewController = gameDetailsModule.viewController as? GameDetailsViewController else { return }
        gameRouter.injectGameDetailsViewController(viewController: gameDetailsViewController)


        tabBarController.setUpTabs()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

