//
//  Service.swift
//  XmlParser
//
//  Created by TRINGAPPS on 24/02/19.
//  Copyright © 2019 TRINGAPPS. All rights reserved.
//

import UIKit

enum ParserErrors: Error {
    case urlError(reason: String)
    case xmlError(reason: String)
}

class Service: NSObject{
    
    static func ApiRequest(requestUrl: URLRequest?, completion: @escaping((Any?, Error?) -> ())) {
        guard let apiRequestUrl = requestUrl, let _ = requestUrl?.url else {
            completion(nil, ParserErrors.urlError(reason: "Invalid url"))
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: apiRequestUrl) { (data, response, error) in
            if((data) != nil) {
                completion(data, nil)
                return
            } else {
                completion(nil, ParserErrors.xmlError(reason: "\(String(describing: error))"))
                return
            }
        }
        dataTask.resume()
        
    }

}
