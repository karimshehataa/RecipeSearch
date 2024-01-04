//
//  Decodable + Parsing.swift
//
//  Created by Karim on 01/03/1444 AH.
//

import Foundation

extension Decodable {
    
    init?(from response: Any?) {
        
        do {
            guard let response = response else { return nil }
            
            let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
            self = try JSONDecoder().decode(Self.self, from: data)
            
        } catch {
            
            return nil
        }
    }
}


import Foundation

extension JSONEncoder {
    func with(encodingStrategy: KeyEncodingStrategy) -> JSONEncoder {
        keyEncodingStrategy = encodingStrategy
        return self
    }
}

extension JSONDecoder {
    func with(decodingStrategy: KeyDecodingStrategy) -> JSONDecoder {
        keyDecodingStrategy = decodingStrategy
        return self
    }
}


extension Encodable {
    func encode() -> Data? {
        return try? JSONEncoder().with(encodingStrategy: .useDefaultKeys).encode(self)
    }
    
    func toDic() -> [String : Any] {
        if let data = encode(), let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            return json as? [String : Any] ?? [:]
        }
        return [:]
    }
}

extension Decodable {
    static func decode(_ data: Data) -> Self? {
        do {
            return try JSONDecoder().with(decodingStrategy: .useDefaultKeys).decode(self, from: data)
        } catch {
            print("Failed To Parse Model: \(error)")
            return nil
        }
    }
}

