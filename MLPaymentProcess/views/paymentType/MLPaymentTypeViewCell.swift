//
// Created by MIGUEL MOLDES on 7/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit

class MLPaymentTypeViewCell : UITableViewCell {

    @IBOutlet weak var label : UILabel!

    func setup(_ type: MLPaymentType) {
        self.label.text = type.name
    }


}