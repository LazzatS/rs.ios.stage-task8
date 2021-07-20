//
//  TimerViewController.swift
//  RSSchool_T8
//
//  Created by Lazzat Seiilova on 19.07.2021.
//

import UIKit

@objc protocol TimeSelectionDelegate {
    func didChooseTime(time: Double)
}

class TimerViewController: UIViewController {

    @objc var delegate: TimeSelectionDelegate?
    
    var saveButton = UIButton()
    var minValueLabel = UILabel()
    var maxValueLabel = UILabel()
    let timeSlider = UISlider(frame: CGRect(x: 16, y: 20, width: 223, height: 4))
    var thumbSliderLabel = UILabel()
    
    var timer1: Timer!
    var timer2: Timer!
    var timer: Timer?
    var runCount: Double = 0
    var chosenTime: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.frame = CGRect(x: 0, y: 333, width: 375, height: 333.5)
        self.view.layer.cornerRadius = 10
        
        createUILabels()
        createSaveButton()
        createTimeSlider()
        
        timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)

        timer2 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in }
        
        
    }
    
    func createUILabels() {
        minValueLabel.frame = CGRect(x: 26, y: 490, width: 11, height: 22)
        minValueLabel.text = "1"
        minValueLabel.textColor = .black
        minValueLabel.font = UIFont(name: "Montserrat-Regular", size: 18)
        self.view.addSubview(minValueLabel)

        maxValueLabel.frame = CGRect(x: 338, y: 490, width: 11, height: 22)
        maxValueLabel.text = "5"
        maxValueLabel.textColor = .black
        maxValueLabel.font = UIFont(name: "Montserrat-Regular", size: 18)
        self.view.addSubview(maxValueLabel)
        
        thumbSliderLabel.frame = CGRect(x: view.frame.size.width / 2, y: 530, width: 52, height: 22)
        thumbSliderLabel.text = "1"
        thumbSliderLabel.textColor = .black
        thumbSliderLabel.font = UIFont(name: "Montserrat-Regular", size: 18)
        self.view.addSubview(thumbSliderLabel)
    }
    
    func createSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor(named: "CustomGreenish"), for: .normal)
        saveButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 18)
        saveButton.frame = CGRect(x: 250, y: 430, width: 85, height: 32)
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderWidth = 1
        saveButton.layer.shadowRadius = 2
        saveButton.layer.shadowColor = UIColor(named: "BlackOpaque")?.cgColor
        saveButton.layer.borderColor = UIColor(named: "BlackOpaque")?.cgColor
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        self.view.addSubview(saveButton)
    }
    
    func createTimeSlider() {
        timeSlider.center = self.view.center
        
        timeSlider.minimumValue = 1.0
        timeSlider.maximumValue = 5.0
        timeSlider.isContinuous = true
        timeSlider.tintColor = UIColor(named: "CustomGreenish")
        timeSlider.addTarget(self, action: #selector(sliderDidSlide(_:)), for: .touchUpInside)
        
        view.addSubview(timeSlider)
    }

    @objc func sliderDidSlide(_ sender: UISlider) {
        let value = sender.value
        thumbSliderLabel.text = String(format: "%.2f s", value)
        chosenTime = Double(value)

    }
    
    @objc func fireTimer() {
        runCount += 1

        if runCount == chosenTime {
            timer?.invalidate()
        }
    }
    
    @objc func saveButtonTapped() {
        navigationController?.popViewController(animated: true)
        delegate?.didChooseTime(time: chosenTime ?? 1)
    }
    
}
