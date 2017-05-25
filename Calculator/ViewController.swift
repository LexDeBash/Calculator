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
    @IBOutlet weak var allClearButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    
    var operatorsArray: [String] = []
    var lastOperator: String = ""
    var equalButtonOn = false
    var dotButtonOn = false
    var newValue = false //Срабатывает после нажатия на любую функциональную клавишу для того чтобы можно было заного набирать цифры после оператора
    var operatorButtonOn = false //Срабатывает после нажатия на любую функциональную клавишу, для того что бы отслеживать, что оператор в данный момнт нажат
    let defaultButtonColor = UIColor(red: 0.192, green: 0.443, blue: 0.659, alpha: 1)
    let activButtonColor = UIColor(red: 0, green: 0.302, blue: 0.529, alpha: 1)
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
        
        clearButton.isHidden = true
        clearButton.isEnabled = false
        
        // Восстанавливаем последнее значение, которое было на экране
        let defaults = UserDefaults.standard
        if let savedValue = defaults.string(forKey: "currentInput") {
            currentInput = Double(savedValue)!
            currentOperand = currentInput
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func allClearButtonPressed(_ sender: UIButton) {
        operatorsArray = []
        equalButtonOn = false
        dotButtonOn = false
        newValue = false
        operatorButtonOn = false
        plusButton.backgroundColor = defaultButtonColor
        minusButton.backgroundColor = defaultButtonColor
        multiButton.backgroundColor = defaultButtonColor
        divisionButton.backgroundColor = defaultButtonColor
        savedValue = nil
        currentOperand = nil
        displayResultLabel.text = "0"
        currentInput = 0
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        displayResultLabel.text = "0"
        currentInput = 0
        clearButton.isHidden = true
        clearButton.isEnabled = false
        allClearButton.isHidden = false
        allClearButton.isEnabled = true
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
        plusButton.backgroundColor = defaultButtonColor
        minusButton.backgroundColor = defaultButtonColor
        multiButton.backgroundColor = defaultButtonColor
        divisionButton.backgroundColor = defaultButtonColor
    }
    
    @IBAction func pressedDigitalButton(_ sender: UIButton) {
        let number = sender.currentTitle
        
        guard (displayResultLabel.text?.characters.count)! < 19 else { return }
        
        if displayResultLabel.text == "0" || newValue {
            displayResultLabel.text = number
            newValue = false
            operatorButtonOn = false
            plusButton.backgroundColor = defaultButtonColor
            minusButton.backgroundColor = defaultButtonColor
            multiButton.backgroundColor = defaultButtonColor
            divisionButton.backgroundColor = defaultButtonColor

        } else {
            displayResultLabel.text = displayResultLabel.text! + number!
        }
        currentOperand = currentInput
        allClearButton.isHidden = true
        allClearButton.isEnabled = false
        clearButton.isHidden = false
        clearButton.isEnabled = true
    }
    
    @IBAction func operatorKey(_ sender: UIButton) {
        lastOperator = ""
        compilation()
        saveValue()
        equalButtonOn = false
        dotButtonOn = false
        lastOperator = sender.currentTitle!
        operatorsArray.append(lastOperator)
        sender.backgroundColor = activButtonColor
        
        switch lastOperator {
        case "+":
            minusButton.backgroundColor = defaultButtonColor
            multiButton.backgroundColor = defaultButtonColor
            divisionButton.backgroundColor = defaultButtonColor
        case "-":
            plusButton.backgroundColor = defaultButtonColor
            multiButton.backgroundColor = defaultButtonColor
            divisionButton.backgroundColor = defaultButtonColor
        case "×":
            minusButton.backgroundColor = defaultButtonColor
            plusButton.backgroundColor = defaultButtonColor
            divisionButton.backgroundColor = defaultButtonColor
        case "÷":
            minusButton.backgroundColor = defaultButtonColor
            multiButton.backgroundColor = defaultButtonColor
            plusButton.backgroundColor = defaultButtonColor
        default:
            break
        }
    }
    
    @IBAction func squareRootKey(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
        newValue = true
        savedValue = nil
        plusButton.backgroundColor = defaultButtonColor
        minusButton.backgroundColor = defaultButtonColor
        multiButton.backgroundColor = defaultButtonColor
        divisionButton.backgroundColor = defaultButtonColor
    }
    
    @IBAction func dotButton(_ sender: UIButton) {
        if !newValue && !dotButtonOn {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotButtonOn = true
        } else if newValue && !dotButtonOn {
            displayResultLabel.text = "0."
        }
        allClearButton.isHidden = true
        allClearButton.isEnabled = false
        clearButton.isHidden = false
        clearButton.isEnabled = true
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        guard !equalButtonOn else {
            compilation() // При повторном нажатии на равно
            operatorButtonOn = false
            plusButton.backgroundColor = defaultButtonColor
            minusButton.backgroundColor = defaultButtonColor
            multiButton.backgroundColor = defaultButtonColor
            divisionButton.backgroundColor = defaultButtonColor
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
        dotButtonOn = false
    }
    
    @IBAction func changeColorWhileButtonPressed(_ sender: UIButton) {
        sender.setBackgroundColor(color: activButtonColor, forState: .highlighted)
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

