//
// Created by MIGUEL MOLDES on 5/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MLInitialView : UIView {

    @IBOutlet weak var continueButtonView : MLContinueButtonView!
    
    @IBOutlet weak var amountText: UITextField!

    private let disposeBag = DisposeBag()
    
    var model : MLInitialViewModel! {
        didSet {
            self.bind()
            self.setup()
        }
    }

    fileprivate func setup() {
        self.continueButtonView.button.addTarget(self, action: #selector(self.continueTouched(_:)), for: .touchUpInside)
        self.amountText.delegate = self
        self.amountText.addTarget(self, action: #selector(textHasChanged(_:)), for: .editingChanged)
        
        self.amountText.keyboardType = .decimalPad
    }

    fileprivate func bind() {
        self.model.buttonEnabled.asObservable().subscribe(onNext: {
            [unowned self] enabled in
            DispatchQueue.main.async {
                self.continueButtonView.button.isEnabled = enabled
                self.continueButtonView.alpha = enabled ? 1.0 : 0.5
            }
        }).disposed(by: self.disposeBag)

    }

    @objc func continueTouched(_ sender : UIButton) {
        if let text = self.amountText.text {
            self.model.continueTouched(amount: text)
        }
    }

    @objc func textHasChanged(_ textField : UITextField) {
        self.model.textHasChanged(textField: textField)
    }
}

extension MLInitialView : UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.text != nil && textField == self.amountText else {
            return false
        }
        return self.model.amountIsValid(textField: textField, text: string)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.model.textHasChanged(textField: textField)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //        self.textFieldFocused = textField
        textField.addDoneButtonOnKeyboard()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //        self.textFieldFocused = nil
        return true
    }

}
