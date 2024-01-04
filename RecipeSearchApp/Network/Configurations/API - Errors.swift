//
//  API - Errors.swift
//
//  Created by Karim on 02/03/1444 AH.
//

import Alamofire

enum APIError: Error {
    
    case noInternetConnection
    case unKnownError
    case parseError
    case timeOut
    case AFError(AFError)
   
}

extension APIError {
    public var errorDescription: String? {
        switch self {
       
        case .noInternetConnection  : return "No Internet Connection, Please try again."
        case .unKnownError          : return "Error Occured, Please try again."
        case .parseError            : return "Parsing Error."
        case .timeOut               : return "Request Time Out."
        case .AFError(let error)    : return  error.errorDescription ?? ""
       
    }
}

}
