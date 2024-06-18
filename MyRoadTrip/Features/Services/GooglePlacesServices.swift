//
//  GooglePlacesServices.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 09/06/24.
//

import Foundation

// MARK: - Class
class GooglePlacesServices {
    
    // MARK: Static variables
    static let justKey = "".localized()
    static let languageCode = "pt-BR"
    static let rankPreference = "POPULARITY"
    static let radius: Double = 10000
    
    static func getAttractionsAround(_ point: LatLong, completion: @escaping (PlaceResponse?) -> Void) {
        getPlacesAround(point, type: .attraction, completion: completion)
    }
    
    static func getHotelsAround(_ point: LatLong, completion: @escaping (PlaceResponse?) -> Void) {
        getPlacesAround(point, type: .hotel, completion: completion)
    }
    
    static private func getPlacesAround(_ point: LatLong, type: PlaceType, completion: @escaping (PlaceResponse?) -> Void) {
        
        var request = getRequest()
        
        let location = LocationRestriction(circle: RestritiveCircle(center: point, radius: radius))
        let body = PlaceRequest(languageCode: languageCode,
                                includedTypes: type.includedTypes(),
                                locationRestriction: location,
                                rankPreference: rankPreference)
        
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
                let routeResponse = try JSONDecoder().decode(PlaceResponse.self, from: data)
                completion(routeResponse)
            }
            catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    static private func getRequest() -> URLRequest {
        
        let url = URL(string: "https://places.googleapis.com/v1/places:searchNearby")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(justKey, forHTTPHeaderField: "X-Goog-Api-Key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let name = "places.name"
        let dName = "places.displayName"
        let fAddress = "places.formattedAddress"
        let sFAddress = "places.shortFormattedAddress"
        let nPNumber = "places.nationalPhoneNumber"
        let iPNumber = "places.internationalPhoneNumber"
        let location = "places.location"
        let rating = "places.rating"
        let webSite = "places.websiteUri"
        let gUri = "places.googleMapsUri"
        request.setValue("\(name),\(dName),\(fAddress),\(sFAddress),\(nPNumber),\(iPNumber),\(location),\(rating),\(gUri),\(webSite)", forHTTPHeaderField: "X-Goog-FieldMask")
        return request
    }
}

// MARK: - Models
extension GooglePlacesServices {
    
    // MARK: Models for request
    struct PlaceRequest: Codable {
        let languageCode: String
        let includedTypes: [String]
        let locationRestriction: LocationRestriction
        let rankPreference: String
    }
    
    struct LocationRestriction: Codable {
        let circle: RestritiveCircle
    }
    
    struct RestritiveCircle: Codable {
        let center: LatLong
        let radius: Double
    }
    
    // MARK: Models for response
    struct PlaceResponse: Decodable {
        let places: [Place]
    }
}

struct Place: Decodable {
    let name: String
    let displayName: LocalizedText
    let formattedAddress: String
    let shortFormattedAddress: String
    let nationalPhoneNumber: String?
    let internationalPhoneNumber: String?
    let location: LatLong
    let rating: Double?
    let googleMapsUri: String
    let websiteUri: String?
}

enum PlaceType {
    case attraction, hotel
    
    func includedTypes() -> [String] {
        switch self {
        case .attraction:
            return ["tourist_attraction"]
        case .hotel:
            return ["hotel", "resort_hotel"]
        }
    }
}
