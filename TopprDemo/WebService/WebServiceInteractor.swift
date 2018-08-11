//
//  WebServiceInteractor.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//

import Foundation

class WebServiceInteractor: HTTPRequest, WebServiceManager {
    
    var requestBody: Data?
    var headers: [String : String]?
    var url: URL = URL(string: "https://www.dropbox.com/s/pbicx3m16xfctgr/ecommerce.json?dl=1")!
    var httpMethod: HTTPMethod {
        return HTTPMethod.get
    }

    /// fetch e-coomerce json from server
    ///
    /// - Parameter completion: response model
    
    func getData(completion: @escaping (Response<ResponseModel?, HTTPError>) -> Void) {
        fetch(with: request, decode: { (response) -> ResponseModel? in
            guard let model = response as? ResponseModel else { return  nil }
            return model
        }, completion: completion)
    }
}
