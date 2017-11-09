//
// Created by MIGUEL MOLDES on 9/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit

class MLInstallmentViewCell : UITableViewCell {

    @IBOutlet weak var title : UILabel!

    var installment : MLInstallment?
    
    func setup(_ installment: MLInstallment) {
        self.installment = installment
        self.title.text = installment.message
    }
    

}