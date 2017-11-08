//
// Created by MIGUEL MOLDES on 8/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import PromiseKit

class MLAssetsManager {

    var cache = Dictionary<String, UIImage>()

    func loadImage(path: String, service: MLLoadImageServiceProtocol) -> Promise<UIImage> {
        return Promise<UIImage> {
            fulfill, reject in

            if let imageCached = cache[path] {
                fulfill(imageCached)
                return
            }
             
            service.execute(path: path).then {
                image -> Void in

                self.cache[path] = image
                fulfill(image)
            }.catch(policy: .allErrors){
                error in
                reject(error)
            }

        }
    }

}