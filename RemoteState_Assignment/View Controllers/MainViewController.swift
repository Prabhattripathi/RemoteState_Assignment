//
//  MainViewController.swift
//  RemoteState_Assignment
//
//  Created by Prabhat on 18/10/21.
//

import UIKit
import SVProgressHUD

class MainViewController: UIViewController {

  @IBOutlet weak var truckListContainerView: UIView!
  @IBOutlet weak var truckMapContainerView: UIView!
  var truckListView: TrucksListTableViewController?
  var truckMapView: TrucksMapViewController?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    //SVProgressHUD.show()

    truckMapContainerView.isHidden = true
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getTruckData()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  func getTruckData() {
    SVProgressHUD.show()
    truckListView = children.first as? TrucksListTableViewController
    getData { truckVM in
      DispatchQueue.main.async {
        SVProgressHUD.dismiss()
        if let listView = self.truckListView {
          listView.truckVM = truckVM
          listView.tableView.reloadData()
        }
      }
    }
  }

  func getTruckMapData() {
    SVProgressHUD.show()
    truckMapView = children.first as? TrucksMapViewController
    getData { truckVM in
      DispatchQueue.main.async {
        SVProgressHUD.dismiss()
        if let listView = self.truckMapView {
          listView.truckVM = truckVM
          listView.addMapView()
        }
      }
    }
  }

  @IBAction func switchViewBtnAction(_ sender: UIButton) {

    sender.isSelected = !sender.isSelected

    truckListContainerView.isHidden = sender.isSelected
    truckMapContainerView.isHidden  = !sender.isSelected

    if truckListContainerView.isHidden {
      truckListView?.removeFromParent()
      getTruckMapData()
    }

    if truckMapContainerView.isHidden {
      truckMapView?.removeFromParent()
      getTruckData()
    }
  }
}

