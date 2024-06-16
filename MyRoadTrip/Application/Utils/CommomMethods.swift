//
//  CommomMethods.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 16/06/24.
//

import UIKit

class CommomMethods {
    
    static func openWaze(with location: LatLong) {
        DispatchQueue.main.async {
            if let url = URL(string: "https://waze.com/ul"),
                UIApplication.shared.canOpenURL(url) {
                // Waze is installed. Launch Waze and start navigation
                let urlStr = String(format: "https://waze.com/ul?ll=%f,%f&navigate=yes", location.latitude, location.longitude)
                UIApplication.shared.open(URL(string: urlStr)!)
            }
        }
    }
}

typealias StringVoid = ((String) -> Void)
typealias LocationVoid = ((LatLong) -> Void)
