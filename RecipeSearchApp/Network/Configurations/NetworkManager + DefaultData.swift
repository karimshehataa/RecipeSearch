//
//  NetworkManager + DefaultData.swift
//
//  Created by Karim on 02/03/1444 AH.
//

import UIKit
import Alamofire

extension API {
    
    func httpMethod(forEndPoint endPoint: EndPoint) -> HTTPMethod {
        
        switch endPoint.method {
        
        case .get:
            return HTTPMethod.get
            
        case .post:
            return HTTPMethod.post
            
        case .put:
            return HTTPMethod.put
            
        case .delete:
            return HTTPMethod.delete
        }
    }
    
    func encoding(forEndPoint endPoint: EndPoint) -> ParameterEncoding {
        
        if let encoding = endPoint.encoding {
            
            return parameterEncoding(forAPIEncoding: encoding)
        }
        
        switch endPoint.method {
        
        case .get:
            return URLEncoding.default
            
        case .post:
            return JSONEncoding.default
            
        default:
            return JSONEncoding.default
        }
    }
    
    func parameterEncoding(forAPIEncoding apiEncoding: APIEncoding) -> ParameterEncoding {
        
        switch apiEncoding {
        
        case .url:
            return URLEncoding.default
            
        case .json:
            return JSONEncoding.default
            
        case .query:
            return URLEncoding.queryString
            
     
            
        }
    }
    
    func httpHeaders(forEndPoint endPoint: EndPoint) -> HTTPHeaders? {
        
        var headers: HTTPHeaders = [:]
        
        headers = defaultHTTPHeaders()
        
        guard let endPointHeaders = endPoint.headers else {
            
            return headers
        }
        
        for header in endPointHeaders {
            headers.add(name: header.key, value: header.value as? String ?? "")
        }
        
        return headers
    }
    
    
    func defaultHTTPHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
        ]
        return headers
    }
    
    
    
    func cancelAllRequests() {
        
        let sessionManager = Alamofire.Session.default
        sessionManager.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
            
        }
    }

    func cancelRequestWithURL(url: String) {
        
        let sessionManager = Alamofire.Session.default
        sessionManager.session.getAllTasks { tasks in
            
            tasks.forEach {
                if ($0.originalRequest?.url?.absoluteString.contains(url) ?? false) {
                    $0.cancel()
                }
            }
        }
    }

}
