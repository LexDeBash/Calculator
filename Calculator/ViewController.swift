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
    var savedValue: Double?
    var currentValue: Double?

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
        } else {
            _operatorButton = operatorsArray.last!
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
        print("Compilation: saveValue = \(savedValue!), currentValue = \(currentValue!)")
    }
    
    func saveValue() {
        if operatorButtonOn == false {
            newValue = true
            operatorButtonOn = true
            if savedValue != nil && equalButtonOn == false {
                screenNumber.text = String(savedValue!)
                print("saveValue: screenNumber = savedValue = \(savedValue!)")
            } else {
                savedValue = Double(screenNumber.text!)!
                print("saveValue: savedValue = screenNumber = \(savedValue!)")
            }
        }
    }
    
    func digitalButton(_ digit: Int) {
        if screenNumber.text == "0" || newValue {
            screenNumber.text = String(digit)
            newValue = false
            operatorButtonOn = false
        } else {
            screenNumber.text = screenNumber.text! + String(digit)
        }
        currentValue = Double(screenNumber.text!)!
        print("digitalButton: currentValue = \(currentValue!)")
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
        print("Plus")
        removedOperator = nil
        compilation()
        saveValue()
        equalButtonOn = false
        operatorsArray.append("+")
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        print("Minus")
        removedOperator = nil
//        equalButtonOn = false
        compilation()
        saveValue()
        equalButtonOn = false
        operatorsArray.append("-")
    }
    
    @IBAction func multiplyButton(_ sender: UIButton) {
        removedOperator = nil
        compilation()
        saveValue()
        equalButtonOn = false
        operatorsArray.append("*")
    }
    
    @IBAction func divisionButton(_ sender: UIButton) {
        removedOperator = nil
        compilation()
        saveValue()
        equalButtonOn = false
        operatorsArray.append("/")
    }
    
    @IBAction func registrChangeKey(_ sender: UIButton) {
        screenNumber.text = String(Double(screenNumber.text!)!*(-1))
        currentValue = Double(screenNumber.text!)!
    }
    
    @IBAction func percentKey(_ sender: UIButton) {
        guard savedValue != nil else { return }
        if operatorsArray.last == "*" {
            compilation()
            savedValue! /= 100
        } else if operatorsArray.last == "/" {
            compilation()
            savedValue! *= 100
        }else {
            currentValue = savedValue!/100 * currentValue!
            compilation()
        }
        screenNumber.text = String(savedValue!)
        operatorsArray = []
        newValue = true
        equalButtonOn = true
    }
    
    @IBAction func squareRootKey(_ sender: UIButton) {
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        print("РАВНО")
        guard equalButtonOn == false else {
            compilation() // При повторном нажатии на равно
            operatorButtonOn = false
            print("Равно: Сработал первый guard и число на экране равно savedValue, т.е. \(savedValue!)")
            return screenNumber.text = String(savedValue!)
        }
        equalButtonOn = true
        guard operatorButtonOn == false else {
            compilation() // При активной клавише оператора
            print("Равно: Сработал второй guard и число на экране равно savedValue, т.е. \(savedValue!)")
            return screenNumber.text = String(savedValue!)
        }
        
        guard savedValue != nil else { return }
        compilation() // Если клавиша оператора и клавиша равно не активны
        screenNumber.text = String(savedValue!)
        removedOperator = operatorsArray.removeLast()
        operatorsArray = []
        newValue = true
        print("Равно: Сработал третий guard и число на экране равно savedValue, т.е. \(savedValue!)")
    }
}

