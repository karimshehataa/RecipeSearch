//
//  EndPoint.swift
//
//  Created by Karim on 01/03/1444 AH.
//

import Foundation


enum APIMethod {
    
    case get
    case post
    case put
    case delete
}

enum APIEncoding {
    
    case url
    case json
    case query
}


struct EndPoint {
    
    // MARK: - Variables
    
    var endPoint: String?
    var method: APIMethod
    var parameters: [String : Any]?
    var encoding: APIEncoding?
    var headers: [String : Any]?
    var configurations: APIConfiguration?
    var fullURL: String?
    
    var url: String {
        print(fullURL ?? "\(environment.baseURL)" + "\(endPoint ?? "")")
        return fullURL ?? "\(environment.baseURL)" + "\(endPoint ?? "")"
        
    }
    
    // MARK: - Initialization

    init() {
    
        self.method = .post
        self.parameters = nil
        self.encoding = nil
        self.headers = nil
        self.fullURL = nil
        self.endPoint = nil
    }
    

    init(
        method: APIMethod? = .post,
         parameters: [String : Any]? = nil,
         encoding: APIEncoding? = nil,
         headers: [String : Any]? = nil,
         fullURL: String? = nil,
        endPoint: String? = nil) {
        self.method = method ?? .post
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
        self.fullURL = fullURL
        self.endPoint = endPoint
    }
}


struct APIConfiguration {
    
    var handleErrorsManually: Bool = false
    var handleNetworkErrorsManually: Bool = false
    var handleNetworkActivityIndicatorManually: Bool = false
    var handleResponseModelManually: Bool = false
    var handleActivityIndicatorManually: Bool = false
}
