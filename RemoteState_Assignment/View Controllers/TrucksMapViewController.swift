//
//  TrucksMapViewController.swift
//  RemoteState_Assignment
//
//  Created by Prabhat on 18/10/21.
//theImageView.image = theImageView.image?.withRenderingMode(.alwaysTemplate)
//theImageView.tintColor = UIColor.red


import UIKit
import GoogleMaps
import CoreLocation

class TrucksMapViewController: UIViewController {
  var truckVM = [TruckViewModel?]()
  let locationManager = CLLocationManager()
  var mapView: GMSMapView!
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    self.locationManager.requestAlwaysAuthorization()

    // For use in foreground
    self.locationManager.requestWhenInUseAuthorization()

    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addMapView()
  }



  func addMapView() {
    guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
    let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 6.0)
    mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
    mapView.isMyLocationEnabled = true
    self.view.addSubview(mapView)

    // Creates a markers in the center of the map.

    truckVM.forEach { truckVM in
      guard let lat = truckVM?.lastWaypoint?.lat else { return }

      guard let lng = truckVM?.lastWaypoint?.lng else { return }

      let marker = GMSMarker()

      marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
      marker.map = mapView
      switch truckVM?.lastRunningState?.truckRunningState {
        case 0:
          marker.icon = UIImage(named: "truck_stop")
        case 1:
          marker.icon = UIImage(named: "truck_running")
        case 2:
          marker.icon = UIImage(named: "truck_idle")
        case 3:
          marker.icon = UIImage(named: "truck_error")
        default:
          marker.icon = UIImage(named: "truck")
      }

    }
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */

}

extension TrucksMapViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 6.0)
    self.mapView?.animate(to: camera)
    print("locations = \(locValue.latitude) \(locValue.longitude)")
  }
}
