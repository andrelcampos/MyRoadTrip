//
//  TripAdvisorServices.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 08/06/24.
//

import Foundation

class TripAdvisorServices {
    
    func getAttractions(at location: String, completion: @escaping (Any?) -> Void) {
        
        let url = URL(string: "https://api.content.tripadvisor.com/api/v1/location/search")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "pt-BR"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["accept": "application/json"]
        
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
                let jsonData = try JSONSerialization.jsonObject(with: data)
                completion(jsonData)
//                let chatResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
//                if let responseMessage = chatResponse.choices.first?.message.content {
//                    if let responseData = responseMessage.data(using: .utf8) {
//                        let decodedResponse = try JSONDecoder().decode(ResponseData.self, from: responseData)
//                        completion(decodedResponse)
//                    } else {
//                        print("Failed to convert response message to data")
//                        completion(nil)
//                    }
//                } else {
//                    completion(nil)
//                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
