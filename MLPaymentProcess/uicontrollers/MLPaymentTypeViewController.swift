//
// Created by MIGUEL MOLDES on 6/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit

class MLPaymentTypeViewController : UIViewController {
    
    var customView : MLPaymentTypeView! {
        get {
            return self.view as! MLPaymentTypeView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customView.viewDidLoad()
    }
}