//
//  OpenAIService.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 05/06/24.
//

import Foundation

class OpenAIServices {
    
    let justKey = "7tYoDmksiDoiVyQIjH9jJFkblB3TR9lDoxD0a8rVCVsaYx6C-jorp-ks".localized()
    let modelID = "gpt-4o"
    
    // Estrutura para definir as mensagens de usuário
    struct Message: Codable {
        let role: String
        let content: String?
    }
    
    // Estrutura para a requisição do chat
    struct ChatRequest: Codable {
        let model: String
        let messages: [Message]
    }
    
    // Estrutura para a resposta do chat
    struct ChatResponse: Codable {
        let id: String
        let object: String
        let created: Int
        let choices: [Choice]
    }
    
    struct Choice: Codable {
        let index: Int
        let message: Message
        let finish_reason: String
    }
    
    // Função para fazer a requisição ao ChatGPT
    func getListOfStopableCitiesTo(origin: String, destination: String, dailyDistance: String, completion: @escaping ([String]?) -> Void) {
        
        completion(["Canoas", "Santa Maria", "Uruguaiana", "Rosario", "Buenos Aires"])
        return
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(justKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Definindo o prompt
        let prompt = """
    Será realizada uma viagem de carro.
    Crie uma rota, mais direta possível, saindo de \(origin) e indo para \(destination).
    Você deve sugerir pontos de parada para descanso, dividindo essa rota a cada \(dailyDistance)Km mais ou menos (variação de no máximo 20%).
    Retornar somente a lista de cidades, não numerada, dos pontos de parada, sendo o primeiro item da lista a cidade de origem.
    """
                
        // Definindo a chamada da função
        let message = Message(role: "user",content: prompt)
        
        let chatRequest = ChatRequest(model: modelID, messages: [message])
        
        do {
            let jsonData = try JSONEncoder().encode(chatRequest)
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
                let chatResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
                if let responseMessage = chatResponse.choices.first?.message.content {
                    let listResponse: [String]
                    if responseMessage.contains("\n") {
                        listResponse = responseMessage.removing(["-", ",", "."]).getArray(separatedBy: "\n")
                    }
                    else if responseMessage.contains(",") {
                        listResponse = responseMessage.removing(["-", "."]).getArray(separatedBy: ",")
                    }
                    else {
                        print("Erro ao criar lista de cidades")
                        completion(nil)
                        return
                    }
                    
                    if listResponse.count > 1 {
                        completion(listResponse)
                    }
                    else {
                        print("Erro do GPT pra buscar encontrar a rota")
                        completion(nil)
                    }
                } else {
                    print("Erro ao tentar encontrar a string de resposta")
                    completion(nil)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
