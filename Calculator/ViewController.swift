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
    
    var operatorsArray: [String] = []
    var removedOperator: String?
    var equalButtonOn = false
    var newValue = false //Срабатывает после нажатия на любую функциональную клавишу для того чтобы можно было заного набирать цифры после оператора
    var operatorButtonOn = false //Срабатывает после нажатия на любую функциональную клавишу, для того что бы отслеживать, что оператор в данный момнт нажат
    var savedValue: Int?
    var currentValue: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func compilation() {
        guard operatorButtonOn == false || equalButtonOn else {
            print("Compilation: First guard")
            return
        } // Отключаем многократное нажатие на функциональные клавиши, за исключением равно
        
        guard operatorsArray.isEmpty == false || removedOperator != nil else {
            print("Compilation: Second guard")
            return
        }
        
        var _operatorButton = ""
        if removedOperator != nil {
            _operatorButton = removedOperator!
            print("compilation: _operatorButton = removedOperator \(_operatorButton)")
        } else {
            _operatorButton = operatorsArray.last!
            print("compilation: _operatorButton = operatorsArray.last \(_operatorButton)")
        }
        switch true {
        case _operatorButton == "+":
            savedValue! += currentValue!
        case _operatorButton == "-":
            savedValue! -= currentValue!
        case _operatorButton == "*":
            savedValue! *= currentValue!
        case _operatorButton == "/":
            savedValue! /= currentValue!
        default:
            print("Compilation false")
            break
        }
    }
    
    func saveValue() {
        if operatorButtonOn == false {
            newValue = true
            print("Func saveValue: newValue true")
            operatorButtonOn = true
            print("Func saveValue: operatorButtonOn true")
            if savedValue != nil && equalButtonOn == false {
                screenNumber.text = String(savedValue!)
                print("Func saveValue: screenNumber = \(savedValue!)")
            } else {
                savedValue = Int(screenNumber.text!)!
                print("Func saveValue: savedValue = \(Int(screenNumber.text!)!)")
            }
        }
    }
    
    func digitalButton(_ digit: Int) {
        if screenNumber.text == "0" || newValue {
            screenNumber.text = String(digit)
            newValue = false
            print("Func digitalButton: newValue false")
            operatorButtonOn = false
            print("Func digitalButton: operatorButtonOn false")
        } else {
            screenNumber.text = screenNumber.text! + String(digit)
        }
        currentValue = Int(screenNumber.text!)!
        print("Func digitalButton: currentValue = \(Int(screenNumber.text!)!)")
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        operatorsArray = []
        equalButtonOn = false
        newValue = false
        operatorButtonOn = false
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
        removedOperator = nil
        equalButtonOn = false
        compilation()
        saveValue()
        operatorsArray.append("+")
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        removedOperator = nil
        equalButtonOn = false
        compilation()
        saveValue()
        operatorsArray.append("-")
    }
    
    @IBAction func multiplyButton(_ sender: UIButton) {
        removedOperator = nil
        equalButtonOn = false
        compilation()
        saveValue()
        operatorsArray.append("*")
    }
    
    @IBAction func divisionButton(_ sender: UIButton) {
        removedOperator = nil
        equalButtonOn = false
        compilation()
        saveValue()
        operatorsArray.append("/")
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        guard equalButtonOn == false else {
            compilation()
            return screenNumber.text = String(savedValue!)
        }
        equalButtonOn = true
        guard operatorButtonOn == false else {
            compilation()
            print("Равно: Первая часть. savedValue = \(savedValue!). currentValue = \(currentValue!)")
            return screenNumber.text = String(savedValue!)
        }
        compilation()
        screenNumber.text = String(savedValue!)
        removedOperator = operatorsArray.removeLast()
        print("Равно: removdOperator = \(removedOperator!)")
        operatorsArray = []
        newValue = true
        print("Равно: Второя часть. savedValue = \(savedValue!). currentValue = \(currentValue!)")
        // 10 - 3 = =
        //
    }
}

