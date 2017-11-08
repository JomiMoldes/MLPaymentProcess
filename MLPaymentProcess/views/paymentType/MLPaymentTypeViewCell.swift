//
// Created by MIGUEL MOLDES on 7/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit

class MLPaymentTypeViewCell : UITableViewCell {

    @IBOutlet weak var label : UILabel!
    @IBOutlet weak var iconImageView : UIImageView!

    var generation = 0

    func setup(_ type: MLPaymentType) {
        self.generation += 1
        self.label.text = type.name
    }


}