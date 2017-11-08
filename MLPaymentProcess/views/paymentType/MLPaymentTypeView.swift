//
// Created by MIGUEL MOLDES on 6/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MLPaymentTypeView : UIView {

    @IBOutlet weak var tableView : UITableView!

    let disposable = DisposeBag()

    var model : MLPaymentTypeViewModel! {
        didSet {
            self.bind()
            self.setup()
            self.model.getPaymentTypes()
        }
    }
    
    fileprivate func bind() {
        self.model.paymentTypes.asObservable()
            .subscribe(onNext: {
                [unowned self] types in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: self.disposable)

    }

    fileprivate func setup() {
        self.tableView.dataSource = self.model
        self.tableView.register(UINib(nibName:"MLPaymentTypeViewCell", bundle:nil), forCellReuseIdentifier: "PaymentTypeViewCell")
    }

    func viewDidLoad() {
        
    }

}