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
    var result: Int?
    var currentNuber: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func compilation() {
        equalButtonOn = false
        
        switch true {
        case plusButtonOn:
            result! += currentNuber!
        case minusButtonOn:
            result! -= currentNuber!
        case multiplyButtonOn:
            result! *= currentNuber!
        case divisionButtonOn:
            result! /= currentNuber!
        default: break
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
    
    func digitalNuber(_ digit: Int) {
        if screenNumber.text == "0" || newNumber {
            screenNumber.text = String(digit)
            newNumber = false
            buttonOn = false
        } else {
            screenNumber.text = screenNumber.text! + String(digit)
        }
        currentNuber = Int(screenNumber.text!)!
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        plusButtonOn = false
        minusButtonOn = false
        multiplyButtonOn = false
        divisionButtonOn = false
        equalButtonOn = false
        newNumber = false
        buttonOn = false
        result = nil
        currentNuber = nil
        screenNumber.text = "0"
    }
    
    @IBAction func zeroButton(_ sender: UIButton) {
        digitalNuber(0)
    }
    
    @IBAction func oneButton(_ sender: UIButton) {
        digitalNuber(1)
    }
    
    @IBAction func twoButton(_ sender: UIButton) {
        digitalNuber(2)
    }
    
    @IBAction func threeButton(_ sender: UIButton) {
        digitalNuber(3)
    }
    
    @IBAction func fourButton(_ sender: UIButton) {
        digitalNuber(4)
    }
    
    @IBAction func fiveButton(_ sender: UIButton) {
        digitalNuber(5)
    }
    
    @IBAction func sixButton(_ sender: UIButton) {
        digitalNuber(6)
    }
    
    @IBAction func sevenButton(_ sender: UIButton) {
        digitalNuber(7)
    }
    
    @IBAction func eightButton(_ sender: UIButton) {
        digitalNuber(8)
    }
    
    @IBAction func nineButton(_ sender: UIButton) {
        digitalNuber(9)
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
        compilation()
        screenNumber.text = String(result!)
        plusButtonOn = false
        minusButtonOn = false
        multiplyButtonOn = false
        divisionButtonOn = false
        equalButtonOn = true
        print("\(result!)")
    }


}

