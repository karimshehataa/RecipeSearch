//
//  NetworkManager.swift
//
//  Created by Karim on 02/03/1444 AH.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

typealias onComplete<T> = (_ result: APIResponseModel<T>) -> Void

class API {
    
    static let shared = API()
    
    init() {}
    
    let session = Alamofire.Session(interceptor: APIInterceptor())
    
    func startAPI<Response: GenericResponse>(endPoint: EndPoint,req: Request? = nil,onComplete: @escaping onComplete<Response>) {
        session.request(endPoint.url, method: httpMethod(forEndPoint: endPoint), parameters: endPoint.parameters, encoding: encoding(forEndPoint: endPoint), headers: httpHeaders(forEndPoint: endPoint)).responseData { response in
            self.handleResponse(response, onComplete: onComplete)
        }
    }
    
    func handleResponse<T:GenericResponse>(_ response: AFDataResponse<Data>,onComplete: @escaping onComplete<T>){
        if case let .success(data) = response.result {
            guard let model = T.decode(data) else {
                onComplete(.failure(.parseError))
                return
            }
            onComplete(.success(model))
        }
        
        if case let .failure(error) = response.result {
            onComplete(.failure(.AFError(error)))
        }
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}

