//
//  ViewController.swift
//  TipCalculator
//
//  Created by MINA FUJISAWA on 2017/10/12.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBAction func calculateBtn(_ sender: Any) {
        getResult()
    }

    @IBAction func tipSlider(_ sender: UISlider) {
        tipPercentageTextField.text = "\(floor(sender.value))"
        getResult()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tipPercentageTextField.text = String(15)
        billAmountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)


        // MARK: Keyboard Notification
        let nofitiShow = Notification.Name.UIKeyboardWillShow
        let nofitiHide = Notification.Name.UIKeyboardWillHide

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow(notification:)),
            name: nofitiShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide(notification:)),
            name: nofitiHide,
            object: nil
        )

    }

    func getResult() {
        var result = Double()
        if !(billAmountTextField.text?.isEmpty)! {
            result = Double(billAmountTextField.text!)! * (1 + Double(tipPercentageTextField.text!)! / 100)
            tipAmountLabel.text = "$ \(result)"
        } else {
            tipAmountLabel.text = "Please input the bill"
        }
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        getResult()
    }

    // MARK: keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        print("open")
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        print("close")
    }
}

