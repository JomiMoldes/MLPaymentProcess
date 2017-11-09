//
// Created by MIGUEL MOLDES on 8/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import PromiseKit
import UIKit

class MLLoadImageService : MLLoadImageServiceProtocol{

    let service : MLServiceProtocol

    init(service: MLServiceProtocol) {
        self.service = service
    }

    func execute(path: String) -> Promise<UIImage?> {
        return Promise<UIImage?> {
            fulfill, reject in
            let request = MLRequest(requestType: .get, path: path)
            self.service.executeData(request, nil).then {
                response -> Void in

                if let image = UIImage(data: response) {
                    fulfill(image)
                    return
                }

                fulfill(nil)

            }.catch(policy:.allErrors) {
                error in
                reject(error)
            }
        }
        
    }

    

}

protocol MLLoadImageServiceProtocol {

    func execute(path: String) -> Promise<UIImage?>

}
