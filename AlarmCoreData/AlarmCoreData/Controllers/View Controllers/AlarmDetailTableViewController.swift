//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by Bryan Gomez on 7/29/21.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmisEnableButton: UIButton!
    
    var alarm: Alarm?
    var isAlarmOn: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
   
    }
    @IBAction func alarmIsEnableButtonTapped(_ sender: Any) {
        if let alarm = alarm {
            AlarmController.shared.toggleIsEnabledFor(alarm: alarm)
            isAlarmOn = alarm.isEnabled
        } else {
            isAlarmOn.toggle()
        }
        
        designIsEnableButton()
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        // save whatever the user wrote on the fields.
        guard let title = alarmTitleTextField.text, !title.isEmpty else { return }
        let fireDate = alarmFireDatePicker.date
        //let isEnable = alarmisEnableButton.isEnabled
        
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, newTitle: title, newFireDate: fireDate, isEnable: isAlarmOn)
        } else {
            AlarmController.shared.createAlarm(withTitle: title, and: fireDate)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateView() {
        guard let alarm = alarm else { return }
        alarmFireDatePicker.date = alarm.fireDate ?? Date()
        alarmTitleTextField.text = alarm.title
        isAlarmOn = alarm.isEnabled
        
        designIsEnableButton() // where we desigh the button layout based on its Bool state.
        
    }
    func designIsEnableButton() {
        switch isAlarmOn {
        case true:
            alarmisEnableButton.backgroundColor = #colorLiteral(red: 0.03490702363, green: 0.6784942627, blue: 0.5271078079, alpha: 1)
            alarmisEnableButton.setTitle("Enabled", for: .normal)
        case false:
            alarmisEnableButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            alarmisEnableButton.setTitle("Disable", for: .normal)
        }
    }
}
