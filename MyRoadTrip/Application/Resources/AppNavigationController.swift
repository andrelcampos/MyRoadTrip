//
//  AppNavigationController.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 10/06/24.
//

import UIKit

// MARK: - Class

class AppNavigationController: UINavigationController {
    
    // MARK: Properties
    
    static var shared = AppNavigationController(nibName: nil, bundle: nil)
    
    // MARK: Initializers
    
    fileprivate override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        AppNavigationController.shared = self
        self.setNavigationBarHidden(true, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK: Internal methods
    
    func push(asRootViewController vc: UIViewController, animated: Bool = true) {
        
        DispatchQueue.main.async {
            self.setViewControllers([vc], animated: animated)
        }
    }
}

extension SceneDelegate {
    
    func appNavigationController(with root: UIViewController)  -> AppNavigationController {
        return AppNavigationController(rootViewController: root)
    }
}
