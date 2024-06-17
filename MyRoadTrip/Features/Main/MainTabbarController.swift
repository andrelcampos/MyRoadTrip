//
//  MainTabbarController.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 11/06/24.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {

    var showOnboarding = true
 
    override func viewDidLoad() {
        super.viewDidLoad()

        let newRouteVC = NewRouteViewController()
        let coordinator = NewRouteCoordinator(controller: newRouteVC)
        let newRouteNavController = UINavigationController(rootViewController: newRouteVC)
        newRouteNavController.tabBarItem = UITabBarItem(title: "Nova Rota", image: UIImage(systemName: "map"), tag: 0)

        let historyVC = HistoryViewController(viewModel: HistoryViewModel())
        let historyNavController = UINavigationController(rootViewController: historyVC)
        historyNavController.tabBarItem = UITabBarItem(title: "Histórico", image: UIImage(systemName: "clock"), tag: 1)
        
        let aboutAppVC = AboutAppViewController()
        let aboutAppNavController = UINavigationController(rootViewController: aboutAppVC)
        aboutAppNavController.tabBarItem = UITabBarItem(title: "Sobre o App", image: UIImage(systemName: "info.circle"), tag: 2)

        viewControllers = [newRouteNavController, historyNavController, aboutAppNavController]
        
        // Configurar a cor da tab bar
        let tabbarAppearance = tabBar.standardAppearance
        tabbarAppearance.configureWithOpaqueBackground()
        tabbarAppearance.backgroundColor = .secondaryBg
        tabBar.scrollEdgeAppearance = tabbarAppearance
        tabBar.standardAppearance = tabbarAppearance
        
        tabBar.barTintColor = .mainTxt
        tabBar.tintColor = .mainTxt
        tabBar.unselectedItemTintColor = .mainBtn
        tabBar.isTranslucent = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if showOnboarding {
            showOnboarding.toggle()
            let onboarding = WelcomeViewController()
            onboarding.modalPresentationStyle = .fullScreen
            self.navigationController?.present(onboarding, animated: true)
        }
    }
}
