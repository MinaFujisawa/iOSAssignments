//
//  ViewController.swift
//  ProgrammaticView
//
//  Created by Derrick Park on 2017-05-24.
//  Copyright © 2017 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	let framingView: UIView = UIView(frame: CGRect.zero)
	let squareButton: UIButton = UIButton(type: .system)
	let portraitButton: UIButton = UIButton(type: .system)
	let landscapeButton: UIButton = UIButton(type: .system)
	var framingViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint.init()
	var framingViewWidthConstraint: NSLayoutConstraint = NSLayoutConstraint.init()

	let purpleBox = UIView(frame: CGRect.zero)
	let yellowBox = UIView()
	let toggleBtn = UIButton()
//    var purpleConstraintBottomToYellow : NSLayoutConstraint? = nil
    var purpleConstraintBottomToYellow = NSLayoutConstraint()
    var purpleConstraintBottomToParent = NSLayoutConstraint()

	override func viewDidLoad() {
		super.viewDidLoad()
		squareButton.setTitle("Square", for: .normal)
		squareButton.addTarget(self, action: #selector(resizeFramingView), for: .touchUpInside)
		view.addSubview(squareButton)
		squareButton.translatesAutoresizingMaskIntoConstraints = false

		portraitButton.setTitle("Portrait", for: .normal)
		portraitButton.addTarget(self, action: #selector(resizeFramingView), for: .touchUpInside)
		view.addSubview(portraitButton)
		portraitButton.translatesAutoresizingMaskIntoConstraints = false

		landscapeButton.setTitle("Landscape", for: .normal)
		landscapeButton.addTarget(self, action: #selector(resizeFramingView), for: .touchUpInside)
		view.addSubview(landscapeButton)
		landscapeButton.translatesAutoresizingMaskIntoConstraints = false

		framingView.translatesAutoresizingMaskIntoConstraints = false
		framingView.backgroundColor = UIColor.green
		view.addSubview(framingView)

		let buttonsHorizontalContraintsFormat = "|[squareButton(==portraitButton)][portraitButton(==landscapeButton)][landscapeButton]|"

		let buttonsHorizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: buttonsHorizontalContraintsFormat, options: .alignAllCenterY, metrics: nil, views: ["squareButton": squareButton, "portraitButton": portraitButton, "landscapeButton": landscapeButton])

		NSLayoutConstraint.activate(buttonsHorizontalContraints)

		let squareButtonBottomConstraint = NSLayoutConstraint.init(item: squareButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -50.0)
		squareButtonBottomConstraint.isActive = true

		let framingViewCenterXContraint = NSLayoutConstraint.init(item: framingView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)

		framingViewCenterXContraint.isActive = true

		let framingViewCenterYContraint = NSLayoutConstraint.init(item: framingView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)

		framingViewCenterYContraint.isActive = true

		framingViewHeightConstraint = NSLayoutConstraint.init(item: framingView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 500.0)
		framingViewHeightConstraint.isActive = true

		framingViewWidthConstraint = NSLayoutConstraint.init(item: framingView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 500.0)
		framingViewWidthConstraint.isActive = true

		// PurpleBox
		purpleBox.translatesAutoresizingMaskIntoConstraints = false
		purpleBox.backgroundColor = UIColor.purple

		framingView.addSubview(purpleBox)

		// BlueBoxes
		let blueParent = UIView()
		let blueBox1 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
		let blueBox2 = UIView(frame: CGRect(x: 0, y: 100, width: 50, height: 50))
		let blueBox3 = UIView(frame: CGRect(x: 0, y: 200, width: 50, height: 50))
		blueBox1.backgroundColor = UIColor.blue
		blueBox2.backgroundColor = UIColor.blue
		blueBox3.backgroundColor = UIColor.blue

		blueParent.addSubview(blueBox1)
		blueParent.addSubview(blueBox2)
		blueParent.addSubview(blueBox3)
		blueParent.translatesAutoresizingMaskIntoConstraints = false
		framingView.addSubview(blueParent)

		// SAME
//        NSLayoutConstraint( item: blueParent, attribute: .centerX, relatedBy: .equal, toItem: framingView,
//                            attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
		blueParent.centerXAnchor.constraint(equalTo: framingView.centerXAnchor).isActive = true
		blueParent.centerYAnchor.constraint(equalTo: framingView.centerYAnchor).isActive = true

		NSLayoutConstraint(item: blueParent, attribute: .width, relatedBy: .equal, toItem: nil,
			attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true

		NSLayoutConstraint(item: blueParent, attribute: .height, relatedBy: .equal, toItem: nil,
			attribute: .notAnAttribute, multiplier: 1.0, constant: 250).isActive = true

		// OrangeBoxes
		let orangeBox1 = UIView(frame: CGRect.zero)
		let orangeBox2 = UIView(frame: CGRect.zero)
		orangeBox1.backgroundColor = UIColor.orange
		orangeBox2.backgroundColor = UIColor.orange
		orangeBox1.layer.borderWidth = 8
		orangeBox2.layer.borderWidth = 8
		orangeBox1.layer.borderColor = UIColor.red.cgColor
		orangeBox2.layer.borderColor = UIColor.red.cgColor

		orangeBox1.translatesAutoresizingMaskIntoConstraints = false
		orangeBox2.translatesAutoresizingMaskIntoConstraints = false
		framingView.addSubview(orangeBox1)
		framingView.addSubview(orangeBox2)

		NSLayoutConstraint(item: orangeBox1, attribute: .width, relatedBy: .equal, toItem: nil,
			attribute: .notAnAttribute, multiplier: 1.0, constant: 80).isActive = true

		NSLayoutConstraint(item: orangeBox2, attribute: .width, relatedBy: .equal, toItem: nil,
			attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true

		NSLayoutConstraint(item: orangeBox1, attribute: .height, relatedBy: .equal, toItem: nil,
			attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true

		NSLayoutConstraint(item: orangeBox2, attribute: .height, relatedBy: .equal, toItem: nil,
			attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true

		NSLayoutConstraint(item: orangeBox1, attribute: .right, relatedBy: .equal, toItem: framingView,
			attribute: .right, multiplier: 1.0, constant: -20).isActive = true

		NSLayoutConstraint(item: orangeBox1, attribute: .top, relatedBy: .equal, toItem: framingView,
			attribute: .top, multiplier: 1.0, constant: 20).isActive = true

		NSLayoutConstraint(item: orangeBox2, attribute: .right, relatedBy: .equal, toItem: orangeBox1,
			attribute: .left, multiplier: 1.0, constant: 0).isActive = true

		NSLayoutConstraint(item: orangeBox2, attribute: .top, relatedBy: .equal, toItem: framingView,
			attribute: .top, multiplier: 1.0, constant: 20).isActive = true

		// Yellow
		yellowBox.backgroundColor = UIColor.yellow
		yellowBox.translatesAutoresizingMaskIntoConstraints = false
		framingView.addSubview(yellowBox)

		NSLayoutConstraint(item: yellowBox, attribute: .height, relatedBy: .equal, toItem: nil,
			attribute: .notAnAttribute, multiplier: 1.0, constant: 150).isActive = true

		NSLayoutConstraint(item: yellowBox, attribute: .width, relatedBy: .equal, toItem: framingView,
			attribute: .width, multiplier: 1.0, constant: 0).isActive = true

		NSLayoutConstraint(item: yellowBox, attribute: .bottom, relatedBy: .equal, toItem: framingView,
			attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true

		NSLayoutConstraint(item: yellowBox, attribute: .left, relatedBy: .equal, toItem: framingView,
			attribute: .left, multiplier: 1.0, constant: 0).isActive = true

		// purple constraint
		purpleConstraintBottomToYellow = NSLayoutConstraint(item: purpleBox, attribute: .bottom, relatedBy: .equal, toItem: yellowBox, attribute: .top, multiplier: 1.0, constant: 0)
        
        purpleConstraintBottomToParent = NSLayoutConstraint(item: purpleBox, attribute: .bottom, relatedBy: .equal, toItem: framingView, attribute: .bottom, multiplier: 1.0, constant: -20)
        
        purpleConstraintBottomToYellow.isActive = true
        purpleConstraintBottomToParent.isActive = false


		NSLayoutConstraint(item: purpleBox, attribute: .right, relatedBy: .equal, toItem: framingView,
			attribute: .right, multiplier: 1.0, constant: -20).isActive = true

		NSLayoutConstraint(item: purpleBox, attribute: .width, relatedBy: .equal, toItem: framingView,
			attribute: .width, multiplier: (305.0 / 500.0), constant: 0).isActive = true

		NSLayoutConstraint(item: purpleBox, attribute: .height, relatedBy: .equal, toItem: nil,
			attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true

		// Button
		toggleBtn.frame = CGRect(x: 100, y: 400, width: 100, height: 50)
		toggleBtn.backgroundColor = UIColor.green
		toggleBtn.setTitle("Click Me", for: .normal)
		toggleBtn.isSelected = true
//        yellowBox.isHidden = true
		toggleBtn.addTarget(self, action: #selector(btnAction(sender:)), for: .touchUpInside)
		toggleBtn.tag = 1
		view.addSubview(toggleBtn)
	}

	func btnAction(sender: UIButton!) {
		let btnsendtag: UIButton = sender
		if btnsendtag.tag == 1 {
			if (toggleBtn.isSelected) {
				yellowBox.isHidden = true
				toggleBtn.isSelected = false
                purpleConstraintBottomToYellow.isActive = false
                purpleConstraintBottomToParent.isActive = true
			} else {
				yellowBox.isHidden = false
				toggleBtn.isSelected = true
                purpleConstraintBottomToYellow.isActive = true
                purpleConstraintBottomToParent.isActive = false
			}
		}
	}

	func resizeFramingView(_ sender: UIButton) {
		var newWidth: CGFloat = 0.0
		var newHeight: CGFloat = 0.0
		if (sender == self.squareButton) {
			newWidth = 500.0
			newHeight = 500.0
		} else if (sender == self.portraitButton) {
			newWidth = 350.0
			newHeight = 550.0
		} else if (sender == self.landscapeButton) {
			newWidth = 900.0
			newHeight = 300.0
		}

		UIView.animate(withDuration: 2.0) {
			self.framingViewHeightConstraint.constant = newHeight
			self.framingViewWidthConstraint.constant = newWidth
			self.view.layoutIfNeeded()
		}
	}
}

