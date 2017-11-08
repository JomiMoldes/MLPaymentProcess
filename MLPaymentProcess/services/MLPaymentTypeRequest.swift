//
// Created by MIGUEL MOLDES on 7/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import Alamofire

class MLRequest : RequestProtocol {

    var body : Data!
    var path : String = ""
    var timeout : Int = 0
    var method : HTTPMethod = .get
    var params = [String:String]()

    init(requestType:HTTPMethod, path: String) {
        self.method = requestType
        self.path = path
    }

    var request: URLRequest? {
        get {
            do {
                let request = try URLRequest(url: URL(fileURLWithPath: self.path), method: self.method)
                return request
            }catch {
                
            }
            return nil
        }
    }
}


protocol RequestProtocol {

    var request : URLRequest? {get}

//    var body : Data {get set}
    var path : String {get}
//    var timeout : Int {get set}
//    var params : [String:String] {get set}
    var method : HTTPMethod {get}

}

protocol ResponseProtocol {
    

}
