//
// Created by MIGUEL MOLDES on 6/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit

class MLPaymentTypeView : UIView {

    var model : MLPaymentTypeViewModel! {
        didSet {
            self.bind()
            self.setup()
        }
    }
    
    fileprivate func bind() {

    }

    fileprivate func setup() {
        
    }

}