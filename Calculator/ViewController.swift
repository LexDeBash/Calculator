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
    var lastOperator: String = ""
    var equalButtonOn = false
    var newValue = false //Срабатывает после нажатия на любую функциональную клавишу для того чтобы можно было заного набирать цифры после оператора
    var operatorButtonOn = false //Срабатывает после нажатия на любую функциональную клавишу, для того что бы отслеживать, что оператор в данный момнт нажат
    var savedValue: Double?
    var currentOperand: Double?
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            
            // Сохраняем значение на экране, для восстановления при следующем запуске приложения
            let defaults = UserDefaults.standard
            defaults.setValue(displayResultLabel.text, forKey: "currentInput")
        }
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        // Восстанавливаем последнее значение, которе было на экране
        let defaults = UserDefaults.standard
        if let savedValue = defaults.string(forKey: "currentInput") {
            currentInput = Double(savedValue)!
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func changeColorWhileButtonPressed(_ sender: UIButton) {
        sender.setBackgroundColor(color: .red, forState: .highlighted)
    }
    
    
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
        currentOperand = currentInput
    }
    
    @IBAction func operatorKey(_ sender: UIButton) {
        lastOperator = ""
        compilation()
        saveValue()
        equalButtonOn = false
        lastOperator = sender.currentTitle!
        operatorsArray.append(lastOperator)
    }
    
    @IBAction func registrChangeKey(_ sender: UIButton) {
        currentInput = -currentInput
        currentOperand = currentInput
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
            currentOperand = savedValue!/100 * currentOperand!
            compilation()
        }
        currentInput = savedValue!
        operatorsArray = []
        newValue = true
        equalButtonOn = true
    }
    
    @IBAction func squareRootKey(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
        newValue = true
        savedValue = nil
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        guard !equalButtonOn else {
            compilation() // При повторном нажатии на равно
            operatorButtonOn = false
            return currentInput = savedValue!
        }
        equalButtonOn = true
        guard !operatorButtonOn else {
            compilation() // При активной клавише оператора
            return currentInput = savedValue!
        }
        
        guard savedValue != nil else { return }
        compilation() // Если клавиша оператора и клавиша равно не активны
        currentInput = savedValue!
        operatorsArray = []
        newValue = true
    }
    
    @IBAction func dotButton(_ sender: UIButton) {
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        operatorsArray = []
        equalButtonOn = false
        newValue = false
        operatorButtonOn = false
        savedValue = nil
        currentOperand = nil
        displayResultLabel.text = "0"
        currentInput = 0
    }
    
    func compilation() {
        // Отключаем многократное нажатие на функциональные клавиши, за исключением равно
        guard !operatorButtonOn || equalButtonOn else {
            return
        }
        
        // Выходим из функции при пустом массиве операторов или если последний оператор не сохранен
        guard !operatorsArray.isEmpty || lastOperator != "" else {
            return
        }
        
        var _operatorButton = ""
        if lastOperator != "" {
            _operatorButton = lastOperator // Извлекаем сохраненный оператор
        } else {
            _operatorButton = operatorsArray.last! // Если сорхраненного оператора нет, берем последний оператор из массива
        }
        switch true {
        case _operatorButton == "+":
            savedValue! += currentOperand!
        case _operatorButton == "-":
            savedValue! -= currentOperand!
        case _operatorButton == "×":
            savedValue! *= currentOperand!
        case _operatorButton == "÷":
            savedValue! /= currentOperand!
        default:
            break
        }
    }
    
    func saveValue() {
        if !operatorButtonOn {
            newValue = true
            operatorButtonOn = true
            if savedValue != nil && !equalButtonOn {
                currentInput = savedValue!
            } else {
                savedValue = currentInput
            }
        }
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }}

