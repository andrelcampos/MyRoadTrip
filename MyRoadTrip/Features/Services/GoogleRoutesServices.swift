//
//  GoogleRoutesServices.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 08/06/24.
//

import Foundation

// MARK: - Class
class GoogleRoutesServices {
    
    // MARK: Static variables
    let justKey = "csAqJYtlaB_GID4Tbpek1HJ0RHH4hxw9BySazIA".localized()
    static let travelMode = "DRIVE"
    static let languageCode = "pt-BR"
    
    // MARK: Static methods
    func getGeneralRoute(from cities: [String], completion: @escaping (Route?) -> Void) {
        
        var request = getRequest()
        request.setValue("routes.localizedValues", forHTTPHeaderField: "X-Goog-FieldMask")
        
        let origin = WayPoint(address: cities.first)
        let destination = WayPoint(address: cities.last)
        let body = RouteRequest(origin: origin,
                                destination: destination,
                                intermediates: intermediateFrom(cities))
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        } catch {
            print("Error encoding JSON: \(error)")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let routeResponse = try JSONDecoder().decode(RouteResponse.self, from: data)
                completion(routeResponse.routes.first)
            }
            catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func getDetailedRoute(from origin: String, to destination: String, completion: @escaping (DetailedRouteResponse?) -> Void) {
        
        var request = getRequest()
        request.setValue("routes.localizedValues,routes.legs,routes.warnings,routes.description", forHTTPHeaderField: "X-Goog-FieldMask")
        
        let origin = WayPoint(address: origin)
        let destination = WayPoint(address: destination)
        let body = RouteRequest(origin: origin,
                                destination: destination,
                                computeAlternativeRoutes: false)
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        } catch {
            print("Error encoding JSON: \(error)")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let routeResponse = try JSONDecoder().decode(DetailedRouteResponse.self, from: data)
                completion(routeResponse)
            }
            catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    // MARK: Private methods
    
    private func getRequest() -> URLRequest {
        
        let url = URL(string: "https://routes.googleapis.com/directions/v2:computeRoutes")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(justKey, forHTTPHeaderField: "X-Goog-Api-Key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func intermediateFrom(_ route: [String]) -> [WayPoint]? {
        guard route.count > 2 else { return nil }
        let mod: Int = route.count / 2
        
        return [WayPoint(address: route[mod], via: true)]
    }
}

// MARK: - Models
extension GoogleRoutesServices {
    
    // MARK: Models for Requests
    
    struct RouteRequest: Codable {
        let origin: WayPoint
        let destination: WayPoint
        let intermediates: [WayPoint]?
        let computeAlternativeRoutes: Bool?
        let travelMode: String
        let languageCode: String
        
        init(origin: WayPoint, destination: WayPoint, intermediates: [WayPoint]? = nil, computeAlternativeRoutes: Bool? = nil) {
            self.origin = origin
            self.destination = destination
            self.intermediates = intermediates
            self.travelMode = GoogleRoutesServices.travelMode
            self.languageCode = GoogleRoutesServices.languageCode
            self.computeAlternativeRoutes = computeAlternativeRoutes
        }
    }
    
    struct WayPoint: Codable {
        let address: String?
        let via: Bool?
        
        init(address: String?, via: Bool? = nil) {
            self.address = address
            self.via = via
        }
    }
    
    // MARK: Models for responses
    
    struct RouteResponse: Decodable {
        let routes: [Route]
    }
    
    struct Route: Decodable {
        let localizedValues: LocalizedValues
    }
    
    struct DetailedRouteResponse: Decodable {
        let routes: [DetailedRoute]
    }
    
    struct DetailedRoute: Decodable {
        let localizedValues: LocalizedValues
        let legs: [Leg]
        let warnings: [String]?
        let description: String
    }
    
    struct Leg: Decodable {
        let localizedValues: LocalizedValues
        let steps: [Step]
        let endLocation: Location
    }
    
    struct Location: Decodable {
        let latLng: LatLong
    }
    
    struct Step: Decodable {
        let localizedValues: LocalizedValues
        let navigationInstruction: NavigationInstruction?
    }
    
    struct NavigationInstruction: Decodable {
        let instructions: String
    }
}

// MARK: - Reused models
struct LatLong: Codable {
    let latitude: Double
    let longitude: Double
}

struct LocalizedValues: Decodable {
    let staticDuration: LocalizedText
    let distance: LocalizedText
    let duration: LocalizedText?
}

struct LocalizedText: Decodable {
    let text: String
}


