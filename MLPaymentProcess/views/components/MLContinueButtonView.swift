//
// Created by MIGUEL MOLDES on 5/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit

class MLContinueButtonView : MLDesignableView {

    @IBOutlet weak var button : UIButton!

    override func xibSetup() {
        self.nibName = "MLContinueButtonView"
        super.xibSetup()
    }
}