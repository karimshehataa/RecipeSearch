//
//  Intercerptors.swift
//
//  Created by Karim on 02/03/1444 AH.
//

import Alamofire

class APIInterceptor: RequestInterceptor {
    
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.retryWithDelay(2))
    }
}

