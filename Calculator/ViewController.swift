//
//  ViewController.swift
//  Calculator
//
//  Created by Alexey Efimov on 15.05.17.
//  Copyright © 2017 LDB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var screenNumber: UILabel!
    
    var plusButtonOn = false
    var minusButtonOn = false
    var multiplyButtonOn = false
    var divisionButtonOn = false
    var newNumber = false
    var buttonOn = false
    var result: Int?
    var currentNuber: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func compilation() {
        if plusButtonOn {
            result! += currentNuber!
        } else if minusButtonOn {
            result! -= currentNuber!
        } else if multiplyButtonOn {
            result! *= currentNuber!
        } else if divisionButtonOn {
            result! /= currentNuber!
        }
    }
    
    func funcButton() {
        if buttonOn == false {
            newNumber = true
            buttonOn = true
            if result != nil {
                screenNumber.text = String(result!)
            } else {
                result = Int(screenNumber.text!)!
            }
        }
    }
    
    @IBAction func fourButton(_ sender: UIButton) {
        if screenNumber.text == "0" || newNumber {
            screenNumber.text = "4"
            newNumber = false
            buttonOn = false
        } else {
            screenNumber.text = screenNumber.text! + "4"
        }
        currentNuber = Int(screenNumber.text!)!
    }
    
    @IBAction func fiveButton(_ sender: UIButton) {
        if screenNumber.text == "0" || newNumber {
            screenNumber.text = "5"
            newNumber = false
            buttonOn = false
        } else {
            screenNumber.text = screenNumber.text! + "5"
        }
        currentNuber = Int(screenNumber.text!)!
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        compilation()
        plusButtonOn = true
        minusButtonOn = false
        multiplyButtonOn = false
        divisionButtonOn = false
        funcButton()
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        compilation()
        plusButtonOn = false
        minusButtonOn = true
        multiplyButtonOn = false
        divisionButtonOn = false
        funcButton()
    }
    
    @IBAction func multiplyButton(_ sender: UIButton) {
        compilation()
        plusButtonOn = false
        minusButtonOn = false
        multiplyButtonOn = true
        divisionButtonOn = false
        funcButton()
    }
    
    @IBAction func divisionButton(_ sender: UIButton) {
        compilation()
        plusButtonOn = false
        minusButtonOn = false
        multiplyButtonOn = false
        divisionButtonOn = true
        funcButton()
    }
    
    @IBAction func equalButton(_ sender: UIButton) {

    }


}

