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
    var equalButtonOn = false
    var newNumber = false
    var buttonOn = false
    var savedValue: Int?
    var currentValue: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func compilation() {
        guard buttonOn == false else { return }
        switch true {
        case plusButtonOn:
            savedValue! += currentValue!
        case minusButtonOn:
            savedValue! -= currentValue!
        case multiplyButtonOn:
            savedValue! *= currentValue!
        case divisionButtonOn:
            savedValue! /= currentValue!
        default: break
        }
    }
    
    func saveValue() {
        if buttonOn == false {
            newNumber = true
            buttonOn = true
            if savedValue != nil && equalButtonOn == false {
                screenNumber.text = String(savedValue!)
            } else {
                savedValue = Int(screenNumber.text!)!
            }
        }
    }
    
    func digitalButton(_ digit: Int) {
        if screenNumber.text == "0" || newNumber {
            screenNumber.text = String(digit)
            newNumber = false
            buttonOn = false
        } else {
            screenNumber.text = screenNumber.text! + String(digit)
        }
        currentValue = Int(screenNumber.text!)!
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        plusButtonOn = false
        minusButtonOn = false
        multiplyButtonOn = false
        divisionButtonOn = false
        equalButtonOn = false
        newNumber = false
        buttonOn = false
        savedValue = nil
        currentValue = nil
        screenNumber.text = "0"
    }
    
    @IBAction func zeroButton(_ sender: UIButton) {
        digitalButton(0)
    }
    
    @IBAction func oneButton(_ sender: UIButton) {
        digitalButton(1)
    }
    
    @IBAction func twoButton(_ sender: UIButton) {
        digitalButton(2)
    }
    
    @IBAction func threeButton(_ sender: UIButton) {
        digitalButton(3)
    }
    
    @IBAction func fourButton(_ sender: UIButton) {
        digitalButton(4)
    }
    
    @IBAction func fiveButton(_ sender: UIButton) {
        digitalButton(5)
    }
    
    @IBAction func sixButton(_ sender: UIButton) {
        digitalButton(6)
    }
    
    @IBAction func sevenButton(_ sender: UIButton) {
        digitalButton(7)
    }
    
    @IBAction func eightButton(_ sender: UIButton) {
        digitalButton(8)
    }
    
    @IBAction func nineButton(_ sender: UIButton) {
        digitalButton(9)
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        compilation()
        saveValue()
        plusButtonOn = true
        minusButtonOn = false
        multiplyButtonOn = false
        divisionButtonOn = false
        equalButtonOn = false
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        compilation()
        saveValue()
        plusButtonOn = false
        minusButtonOn = true
        multiplyButtonOn = false
        divisionButtonOn = false
        equalButtonOn = false
    }
    
    @IBAction func multiplyButton(_ sender: UIButton) {
        compilation()
        saveValue()
        plusButtonOn = false
        minusButtonOn = false
        multiplyButtonOn = true
        divisionButtonOn = false
        equalButtonOn = false
    }
    
    @IBAction func divisionButton(_ sender: UIButton) {
        compilation()
        saveValue()
        plusButtonOn = false
        minusButtonOn = false
        multiplyButtonOn = false
        divisionButtonOn = true
        equalButtonOn = false
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        compilation()
        screenNumber.text = String(savedValue!)
        plusButtonOn = false
        minusButtonOn = false
        multiplyButtonOn = false
        divisionButtonOn = false
        newNumber = true
        equalButtonOn = true
    }


}

