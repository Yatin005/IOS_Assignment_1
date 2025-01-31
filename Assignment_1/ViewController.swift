//
//  ViewController.swift
//  Assignment_1
//
//  Created by Yatin Parulkar on 2025-01-31.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Weight_Change: UILabel!
    @IBOutlet weak var height_change: UILabel!
    @IBOutlet weak var Height_textfield: UITextField!
    @IBOutlet weak var Weight_textfield: UITextField!
    @IBOutlet weak var convertButton: UIButton!
    
    @IBOutlet weak var toggle: UISegmentedControl!
    @IBOutlet weak var Result_textfield: UITextField!
    
    var isSimple: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Result_textfield.text = ""
        // Do any additional setup after loading the view.
    }
    @IBAction func Calculate_bmi(_ sender: Any) {
             guard let hight = Height_textfield.text,
              let weight = Weight_textfield.text,
              let hight_T = Double(hight),
              let weight_T = Double(weight),
            hight_T > 0 || hight_T < 300  , weight_T > 0 || weight_T < 300
        else {
            Result_textfield.text = "Enter Height and Weight.."
            return
            
        }
        var bmi: Double = 0.0
        
        if isSimple {
            let hight_meter = hight_T / 100
            bmi = weight_T / (hight_meter * hight_meter)
            
        } else {
            bmi = (weight_T / (hight_T * hight_T)) * 703
        }
        
        let category = getBMICategory(bmi)
        Result_textfield.text = "Your BMI: \(String(format: "%.2f", bmi)) (\(category))"
    }
    @IBAction func Clear_field(_ sender: Any) {
        Height_textfield.text = ""
        Weight_textfield.text = ""
        Result_textfield.text = ""
    }
    @IBAction func toggler(_ sender: Any) {

         guard let weightText = Weight_textfield.text, 
              let heightText = Height_textfield.text,
              let weight = Double(weightText),
              let height = Double(heightText)
        else {
            Result_textfield.text = "Enter valid values first!"
            return
        } 
        if isSimple {
            let conver_We = weight * 2.20
            let convert_H = height * 0.39 // cm
            Weight_textfield.text = String(format: "%.2f", conver_We)
            Height_textfield.text = String(format: "%.2f", convert_H)
            height_change.text = "Your Height (in)"
            Weight_Change.text = "Your Weight(lb)"
            convertButton.setTitle("Convert to Pounds/Inches", for: .normal)
            
        }
        else { // Convert in simple
            let conver_we = weight / 2.20 // lb to kg
            let convert_H = height / 0.39 // in to cm
            Weight_textfield.text = String(format: "%.2f", conver_we)
            Height_textfield.text = String(format: "%.2f", convert_H)
            height_change.text = "Your Height (cm)"
            Weight_Change.text = "Your Weight(kg)"
            convertButton.setTitle("Convert to Kilograms/Centimeters", for: .normal)
        }
        isSimple.toggle() // Switch
    }
    func getBMICategory(_ bmi: Double) -> String {
        switch bmi { case ..<18.5:
            return "Underweight"
        case 18.5..<24.9:
            return "Normal weight"
        case 25..<29.9:
            return "Overweight"
        default:
            return "Obese"
        }
    }
}
