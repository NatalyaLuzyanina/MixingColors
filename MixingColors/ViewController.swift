//
//  ViewController.swift
//  MixingColors
//
//  Created by Natalia on 23.05.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    private var tappedButtonTag: Int?
    
    @IBOutlet weak var colorOneButton: UIButton!
    @IBOutlet weak var colorTwoButton: UIButton!
    @IBOutlet weak var resultColorView: UIView!
    
    @IBOutlet weak var colorOneLabel: UILabel!
    @IBOutlet weak var colorTwoLabel: UILabel!
    @IBOutlet weak var resultColorLabel: UILabel!
    
    @IBAction func colorButtonTapped(_ sender: UIButton) {
        tappedButtonTag = sender.tag
        showPicker()
    }
    
    private func setSelectedColor(_ color: UIColor) {
        guard let buttonTag = tappedButtonTag else { return }
        
        let colorButtons = [colorOneButton, colorTwoButton]
        let colorLabels = [colorOneLabel, colorTwoLabel]
        
        guard buttonTag >= 1 && buttonTag <= colorButtons.count else {
            return
        }
        
        let index = buttonTag - 1
        let colorButton = colorButtons[index]
        let colorLabel = colorLabels[index]
        
        colorButton?.backgroundColor = color
        getNameOfColor(color: color) { colorName in
            colorLabel?.text = colorName
        }
        
        setResultColor()
    }
    
    private func getNameOfColor(color: UIColor, completion: @escaping (String) -> Void) {
        let components = color.cgColor.components?
            .compactMap { Float($0) * 255 }
            .compactMap { String(Int($0)) }.joined(separator: ",")
        guard let components = components else { return }
        
        NetworkManager.shared.getNameOfColor(withComponents: components) { colorName in
            DispatchQueue.main.async {
                completion(colorName)
            }
        }
    }
    
    private func setResultColor() {
        guard let resultColor = ColorManager.shared.mix(colors: [
            colorOneButton.backgroundColor ?? .white,
            colorTwoButton.backgroundColor ?? .white
        ])
        else { return }
        
        getNameOfColor(color: resultColor) { colorName in
            self.resultColorLabel.text = colorName
        }
        
        UIView.animate(withDuration: 1.5) {
            self.resultColorView.backgroundColor = resultColor
        }
    }
}

extension ViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        setSelectedColor(color)
    }
    
    private func showPicker() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
}
