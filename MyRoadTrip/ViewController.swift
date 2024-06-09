//
//  ViewController.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 05/06/24.
//

import UIKit

class ViewController: UIViewController {

    enum ServiceToTest {
        case gpt, google, advisor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let testing: ServiceToTest = .gpt
        
        switch testing {
        case .gpt:
            OpenAIServices.makeChatGPTRequest { trip in
                guard let trip = trip else { return }
                print(trip)
            }
        case .google:
            break
        case .advisor:
            break
        }
    }
}

