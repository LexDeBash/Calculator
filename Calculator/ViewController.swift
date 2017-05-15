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
    var tempResult = 0
    var newNumber = false
    var buttonOn = false
    var lastNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func fourButton(_ sender: UIButton) {
        lastNumber = 0
        if screenNumber.text == "0" || newNumber {
            screenNumber.text = "4"
            newNumber = false
            buttonOn = false
        } else {
            screenNumber.text = screenNumber.text! + "4"
        }

    }
    @IBAction func fiveButton(_ sender: UIButton) {
        lastNumber = 0
        if screenNumber.text == "0" || newNumber {
            screenNumber.text = "5"
            newNumber = false
            buttonOn = false
        } else {
            screenNumber.text = screenNumber.text! + "5"
        }
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        if buttonOn == false {
            newNumber = true
            buttonOn = true
            tempResult += Int(screenNumber.text!)!
            screenNumber.text = String(tempResult)
        }
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        newNumber = true
        buttonOn = true
        if lastNumber != 0 {
            tempResult += lastNumber
            screenNumber.text = String(tempResult)
        } else {
            lastNumber = Int(screenNumber.text!)!
            tempResult += lastNumber
            screenNumber.text = String(tempResult)
        }
    }


}

