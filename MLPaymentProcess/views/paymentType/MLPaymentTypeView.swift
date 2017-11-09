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

    @IBOutlet weak var continueButtonView : MLContinueButtonView!

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

        self.model.buttonEnabled.asObservable().subscribe(onNext: {
            [unowned self] enabled in
            self.continueButtonView.button.isEnabled = enabled
            self.continueButtonView.alpha = enabled ? 1.0 : 0.5
        }).disposed(by: self.disposable)

    }

    fileprivate func setup() {
        self.tableView.dataSource = self.model
        self.tableView.delegate = self.model
        self.tableView.register(UINib(nibName:"MLPaymentTypeViewCell", bundle:nil), forCellReuseIdentifier: "PaymentTypeViewCell")

        self.continueButtonView.button.addTarget(self, action: #selector(self.continueTouched(_:)), for: .touchUpInside)
    }

    @objc func continueTouched(_ sender : UIButton) {
        self.model.continueTouched()
    }

    func viewDidLoad() {
        
    }

}