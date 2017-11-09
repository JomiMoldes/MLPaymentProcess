//
// Created by MIGUEL MOLDES on 9/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit

class MLBackButtonView : MLDesignableView {

    override func xibSetup() {
        self.nibName = "MLBackButtonView"
        super.xibSetup()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("backButtonPressed"), object: nil)
    }
}