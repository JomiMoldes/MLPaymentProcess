//
// Created by MIGUEL MOLDES on 5/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class MLInitialViewController : UIViewController {

    var initialView : MLInitialView {
        get {
            return self.view as! MLInitialView
        }
    }

    private let disposeBag = DisposeBag()

    func setupModel(model: MLInitialViewModel) {
        self.initialView.model = model
        self.bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initialView.model.viewDidLoad()
    }

    //MARK - Private

    fileprivate func bind() {
        self.initialView.model.resumeAlert.asObservable()
        .subscribe(onNext: {
            [unowned self] alert in
            DispatchQueue.main.async {
                self.navigationController?.present(alert, animated: true)
            }
        }).disposed(by: self.disposeBag)
    }

}

