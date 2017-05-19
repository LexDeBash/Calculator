//
//  ViewController.swift
//  Calculator
//
//  Created by Alexey Efimov on 15.05.17.
//  Copyright © 2017 LDB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayResultLabel: UILabel!
    
    var operatorsArray: [String] = []
    var removedOperator: String?
    var equalButtonOn = false
    var newValue = false //Срабатывает после нажатия на любую функциональную клавишу для того чтобы можно было заного набирать цифры после оператора
    var operatorButtonOn = false //Срабатывает после нажатия на любую функциональную клавишу, для того что бы отслеживать, что оператор в данный момнт нажат
    var savedValue: Double?
    var currentValue: Double?
    
    @IBAction func pressedDigitalButton(_ sender: UIButton) {
        let number = sender.currentTitle
        
        guard (displayResultLabel.text?.characters.count)! < 19 else { return }
        
        if displayResultLabel.text == "0" || newValue {
            displayResultLabel.text = number
            newValue = false
            operatorButtonOn = false
        } else {
            displayResultLabel.text = displayResultLabel.text! + number!
        }
        currentValue = Double(displayResultLabel.text!)!
        print("digitalButton: currentValue = \(currentValue!)")
    }
    
    @IBAction func operatorKey(_ sender: UIButton) {
        let lastOperator = sender.currentTitle
        print("Key \(lastOperator!)")
        removedOperator = nil
        compilation()
        saveValue()
        equalButtonOn = false
        operatorsArray.append(lastOperator!)
    }
    
    func compilation() {
        // Отключаем многократное нажатие на функциональные клавиши, за исключением равно
        guard operatorButtonOn == false || equalButtonOn else {
            print("Compilation: First guard")
            return
        }
        
        // Выходим из функции при пустом массиве операторов или если последний оператор не сохранен
        guard operatorsArray.isEmpty == false || removedOperator != nil else {
            print("Compilation: Second guard")
            return
        }
        
        var _operatorButton = ""
        if removedOperator != nil {
            _operatorButton = removedOperator! // Извлекаем сохраненный оператор
        } else {
            _operatorButton = operatorsArray.last! // Если сорхраненного оператора нет, берем последний оператор из массива
        }
        switch true {
        case _operatorButton == "+":
            savedValue! += currentValue!
        case _operatorButton == "-":
            savedValue! -= currentValue!
        case _operatorButton == "×":
            savedValue! *= currentValue!
        case _operatorButton == "÷":
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
                displayResultLabel.text = String(savedValue!)
                print("saveValue: displayResultLabel = savedValue = \(savedValue!)")
            } else {
                savedValue = Double(displayResultLabel.text!)!
                print("saveValue: savedValue = displayResultLabel = \(savedValue!)")
            }
        }
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        operatorsArray = []
        equalButtonOn = false
        newValue = false
        operatorButtonOn = false
        savedValue = nil
        currentValue = nil
        displayResultLabel.text = "0"
    }
    
    @IBAction func registrChangeKey(_ sender: UIButton) {
        displayResultLabel.text = String(Double(displayResultLabel.text!)!*(-1))
        currentValue = Double(displayResultLabel.text!)!
    }
    
    @IBAction func percentKey(_ sender: UIButton) {
        guard savedValue != nil else { return }
        if operatorsArray.last == "×" {
            compilation()
            savedValue! /= 100
        } else if operatorsArray.last == "÷" {
            compilation()
            savedValue! *= 100
        }else {
            currentValue = savedValue!/100 * currentValue!
            compilation()
        }
        displayResultLabel.text = String(savedValue!)
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
            return displayResultLabel.text = String(savedValue!)
        }
        equalButtonOn = true
        guard operatorButtonOn == false else {
            compilation() // При активной клавише оператора
            print("Равно: Сработал второй guard и число на экране равно savedValue, т.е. \(savedValue!)")
            return displayResultLabel.text = String(savedValue!)
        }
        
        guard savedValue != nil else { return }
        compilation() // Если клавиша оператора и клавиша равно не активны
        displayResultLabel.text = String(savedValue!)
        removedOperator = operatorsArray.removeLast()
        operatorsArray = []
        newValue = true
        print("Равно: Сработал третий guard и число на экране равно savedValue, т.е. \(savedValue!)")
    }
}

