//
//  StringUtils.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 09/06/24.
//

import Foundation

extension String {
    
    var isNotEmpty: Bool {
        
        return !self.isEmpty
    }

    func removing(_ strings: [String]) -> String {
        var toList: [String] = []
        for _ in strings { toList.append("") }
        return replace(of: strings, to: toList)
    }
    
    func replace(of listOf: Array<String>, to listTo: Array<String>) -> String {
        
        var str = self
        
        if listOf.count == listTo.count {
            
            listOf.enumerated().forEach { pair in
                
                str = str.replacingOccurrences(of: pair.element, with: listTo[pair.offset])
            }
            
            return str
        }
        else if let toStr = listTo.first, listTo.count == 1 {
            
            listOf.forEach({ str = str.replacingOccurrences(of: $0, with: toStr) })
            
            return str
        }
        else {
            
            return str
        }
    }
    
    func getArray(separatedBy separator: String) -> [String] {
        
        let listSubs = self.split(separator: separator)
        var result: [String] = []
        for sub in listSubs {
            result.append(String(sub))
        }
        return result
    }
    
    func contains(_ find: String) -> Bool {
        
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
