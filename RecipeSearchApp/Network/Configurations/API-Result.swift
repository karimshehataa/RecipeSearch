//
//  API-Result.swift
//
//  Created by Karim on 02/03/1444 AH.
//

import UIKit


enum APIResponseModel<T> {
    case success(T)
    case failure(APIError)
    
}
enum DownloadResponseModel {
    case success(URL?)
    case failure(APIError)
    
}
enum DownloadImageResponseModel {
    case success(Data?)
    case failure(APIError)
    
}


protocol GenericResponse: Codable {

//    var errorCode: String? { get set }
    var code: Int? { get set }
    
}

