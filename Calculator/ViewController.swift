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
    var newNumber = false //Срабатывает после нажатия на любую функциональную клавишу для того чтобы можно было заного набирать цифры после оператора
    var buttonOn = false //Срабатывает после нажатия на любую функциональную клавишу, для того что бы отслеживать, что оператор в данный момнт нажат
    var savedValue: Int?
    var currentValue: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func compilation() {
        guard buttonOn == false || equalButtonOn else {
            print("Compilation: guard")
            return
        } // Отключаем многократное нажатие на функциональные клавиши, за исключением равно
        switch true {
        case plusButtonOn:
            savedValue! += currentValue!
            print("Compilation with plus. savedValue = \(savedValue!)")
        case minusButtonOn:
            savedValue! -= currentValue!
            print("Compilation with minus. savedValue = \(savedValue!)")
        case multiplyButtonOn:
            savedValue! *= currentValue!
            print("Compilation with multi. savedValue = \(savedValue!)")
        case divisionButtonOn:
            savedValue! /= currentValue!
            print("Compilation with division. savedValue = \(savedValue!)")
        default:
            print("Compilation false")
            break
        }
    }
    
    func saveValue() {
        if buttonOn == false {
            newNumber = true
            print("Func saveValue: newNumber true")
            buttonOn = true
            print("Func saveValue: buttonOn true")
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
        if screenNumber.text == "0" || newNumber {
            screenNumber.text = String(digit)
            newNumber = false
            print("Func digitalButton: newNumber false")
            buttonOn = false
            print("Func digitalButton: buttonOn false")
        } else {
            screenNumber.text = screenNumber.text! + String(digit)
        }
        currentValue = Int(screenNumber.text!)!
        print("Func digitalButton: currentValue = \(Int(screenNumber.text!)!)")
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
        equalButtonOn = false
        compilation()
        saveValue()
        plusButtonOn = true
        minusButtonOn = false
        multiplyButtonOn = false
        divisionButtonOn = false
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        equalButtonOn = false
        compilation()
        saveValue()
        plusButtonOn = false
        minusButtonOn = true
        multiplyButtonOn = false
        divisionButtonOn = false
    }
    
    @IBAction func multiplyButton(_ sender: UIButton) {
        equalButtonOn = false
        compilation()
        saveValue()
        plusButtonOn = false
        minusButtonOn = false
        multiplyButtonOn = true
        divisionButtonOn = false
    }
    
    @IBAction func divisionButton(_ sender: UIButton) {
        equalButtonOn = false
        compilation()
        saveValue()
        plusButtonOn = false
        minusButtonOn = false
        multiplyButtonOn = false
        divisionButtonOn = true
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        equalButtonOn = true
        guard buttonOn == false else {
            compilation()
            print("Первая часть. savedValue = \(savedValue!). currentValue = \(currentValue!)")
            return screenNumber.text = String(savedValue!)
        }
        compilation()
        screenNumber.text = String(savedValue!)
        plusButtonOn = false
        minusButtonOn = false
        multiplyButtonOn = false
        divisionButtonOn = false
        newNumber = true
        print("Второя часть. savedValue = \(savedValue!). currentValue = \(currentValue!)")
        // Не проходит тест: 4 + 2 = =
    }
}

