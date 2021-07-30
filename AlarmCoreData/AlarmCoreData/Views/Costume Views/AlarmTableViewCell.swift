//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by Bryan Gomez on 7/29/21.
//

import UIKit
protocol AlaramTableViewCellDelegate: AnyObject {
    func alarmWasToggled(sender: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    var alarm: Alarm?
    weak var delegate: AlaramTableViewCellDelegate?
    
    @IBAction func isEnabledSwitchToggled(_ sender: Any) {
        delegate?.alarmWasToggled(sender: self)
    }
    
    func updateViews(with alarm: Alarm) {
        alarmTitleLabel.text = alarm.title
        alarmFireDateLabel.text = alarm.fireDate?.dateAsString()
        isEnabledSwitch.isOn = alarm.isEnabled
        
    }
   

}
