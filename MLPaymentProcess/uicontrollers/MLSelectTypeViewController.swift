//
// Created by MIGUEL MOLDES on 6/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit

class MLSelectTypeViewController: UIViewController {
    
    var customView : MLSelectTypeView! {
        get {
            return self.view as! MLSelectTypeView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customView.viewDidLoad()
    }
}