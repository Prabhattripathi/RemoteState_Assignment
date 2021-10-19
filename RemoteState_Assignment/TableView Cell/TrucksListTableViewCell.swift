//
//  TrucksListTableViewCell.swift
//  RemoteState_Assignment
//
//  Created by Prabhat on 18/10/21.
//

import UIKit

class TrucksListTableViewCell: UITableViewCell {

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var truckNumberLabel: UILabel!
  @IBOutlet weak var lastUpdatedLabel: UILabel!
  @IBOutlet weak var truckStatusLabel: UILabel!
  @IBOutlet weak var truckSpeedLabel: UILabel!
  let numbers = ["0","1","2","3","4","5","6","7","8","9", "."]
  var truckViewModel: TruckViewModel? {
    didSet {
      let startStopString = epochTimeToHumanReadable(timeStamp: truckViewModel?.lastRunningState?.stopStartTime ?? 0)



      guard let truckSpeed = truckViewModel?.lastWaypoint?.speed else { return }

      let truckSpeedString = String(format: "%.2f", truckSpeed)

      let attributedWithTextColor: NSAttributedString = startStopString.attributedStringWithColor(numbers, color: UIColor(red: 191/255, green: 72/255, blue: 61/255, alpha: 1))

      lastUpdatedLabel.attributedText = attributedWithTextColor

      guard let truckNumber = truckViewModel?.truckNumber else { return }

      guard let truckRunningStatus = truckViewModel?.lastRunningState?.truckRunningState else { return }

      truckNumberLabel.text = truckNumber

      let status = startStopString

      let statusString = status.replacingOccurrences(of: "ago", with: "")

      truckStatusLabel.text = truckRunningStatus == 0 ? "Stopped since last \(statusString)" : "Running since last \(statusString)"

      truckSpeedLabel.attributedText = truckRunningStatus == 0 ? NSAttributedString(string: "") : "\(truckSpeedString) k/h".attributedStringWithColor(numbers, color: UIColor(red: 191/255, green: 72/255, blue: 61/255, alpha: 1))
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    containerView.layer.cornerRadius = 8
    addShadow(view: contentView)

  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func addShadow(view: UIView) {
    view.layer.masksToBounds = false;
    view.layer.shadowColor = UIColor.lightGray.cgColor;
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowOpacity = 1;
  }

}

extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {

      let myAttributedString = NSMutableAttributedString(string: self)
          var locations: [Int] = []
          let characters = self
          var i = 0
          for letter in characters {
              i = i + 1
              if strings.contains(String(letter)) {
                  locations.append(i)
              }
          }

          for item in locations {
              let myRange = NSRange(location: item - 1, length: 1)
              myAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: myRange)
          }

        return myAttributedString
    }
}
