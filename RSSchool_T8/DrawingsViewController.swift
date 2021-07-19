//
//  DrawingsViewController.swift
//  RSSchool_T8
//
//  Created by Lazzat Seiilova on 17.07.2021.
//

import UIKit

@objc protocol DrawingSelectionDelegate {
    func didChooseDrawing(imageTitle: String)
}

@objc class DrawingsViewController: UIViewController {
    
    @objc var delegate: DrawingSelectionDelegate?
    
    var buttonTitles = ["Planet", "Head", "Tree", "LandScape"]
    var buttons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Drawings"
        self.view.backgroundColor = .white
        let navAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 17)]
        UINavigationBar.appearance().titleTextAttributes = navAttributes as [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.tintColor = UIColor(named: "CustomGreenish")
        
        var diff: CGFloat = 0
        
        for buttonTitle in buttonTitles {
            let newButton = styleButton(title: buttonTitle, positionY: 114 + diff)
            buttons.append(newButton)
            self.view.addSubview(newButton)
            diff += 55
        }
        
        for button in buttons {
            button.addTarget(self, action: #selector(changeButtonStyle), for: .touchUpInside)
        }
        
        
    }
    
    private func styleButton(title: String, positionY: CGFloat) -> UIButton {
        let buttonStyle = UIButton()
        buttonStyle.setTitle(title, for: .normal)
        buttonStyle.setTitleColor(UIColor(named: "CustomGreenish"), for: .normal)
        buttonStyle.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        buttonStyle.frame = CGRect(x: 88, y: positionY, width: 200, height: 40)
        buttonStyle.layer.cornerRadius = 10
        buttonStyle.layer.borderWidth = 1
        buttonStyle.layer.shadowRadius = 2
        buttonStyle.layer.shadowColor = UIColor(named: "BlackOpaque")?.cgColor
        buttonStyle.layer.borderColor = UIColor(named: "BlackOpaque")?.cgColor
        return buttonStyle
    }
    
    @objc func changeButtonStyle(sender: UIButton) {
        sender.layer.borderColor = UIColor(named: "CustomGreenish")?.cgColor
        sender.layer.shadowColor = UIColor(named: "CustomGreenish")?.cgColor
        sender.layer.shadowRadius = 4
        
        if sender.titleLabel != nil {
            navigationController?.popViewController(animated: true)
            let buttonTitle = sender.titleLabel?.text ?? "Head"
            delegate?.didChooseDrawing(imageTitle: buttonTitle)
        }
    }
}
