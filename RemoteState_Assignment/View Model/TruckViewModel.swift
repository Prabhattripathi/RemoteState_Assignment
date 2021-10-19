//
//  TruckViewModel.swift
//  RemoteState_Assignment
//
//  Created by Prabhat on 18/10/21.
//

import Foundation

struct TruckViewModel {
  let truckNumber: String?
  let lastWaypoint: TruckLastWaypoint?
  let lastRunningState: TruckLastRunningState?

  init (truckData: Datum) {
    truckNumber = truckData.truckNumber
    lastWaypoint = TruckLastWaypoint(lastWayPoint: truckData.lastWaypoint!)
    lastRunningState = TruckLastRunningState(lastRunningData: truckData.lastRunningState!)
  }
}

// MARK: - LastRunningState
struct TruckLastRunningState: Codable {
  let stopStartTime, truckRunningState: Int?

  init(lastRunningData: LastRunningState) {
    stopStartTime = lastRunningData.stopStartTime
    truckRunningState = lastRunningData.truckRunningState
  }
}

// MARK: - LastWaypoint
struct TruckLastWaypoint: Codable {
  let lat, lng: Double?
  let createTime: Int?
  let speed: Double?
  let ignitionOn: Bool?

  init(lastWayPoint: LastWaypoint) {
    lat = lastWayPoint.lat
    lng = lastWayPoint.lng
    createTime = lastWayPoint.createTime
    speed = lastWayPoint.speed
    ignitionOn = lastWayPoint.ignitionOn
  }
}

func getData(complition: @escaping([TruckViewModel?]) -> ()) {
  var truckVM = [TruckViewModel]()
  guard
    let url = URL(string: "https://api.mystral.in/tt/mobile/logistics/searchTrucks?auth-company=PCH&companyId=33&deactivated=false&key=g2qb5jvucg7j8skpu5q7ria0mu&q-expand=true&q-include=lastRunningState,lastWaypoint")
  else {
    return
  }
  let task = URLSession.shared.truckModelTask(with: url) { truckModel, response, error in
    if let truckModel = truckModel {
      truckVM = truckModel.data?.map({return TruckViewModel(truckData: $0 )}) ?? []
      complition(truckVM)
    }
  }
  task.resume()
}


func epochTimeToHumanReadable(timeStamp: Int) -> String {
  //convert miliseconds to seconds
  let epochTime = TimeInterval(timeStamp) / 1000

  let exampleDate = Date(timeIntervalSince1970:epochTime)

  // ask for the full relative date
  let formatter = RelativeDateTimeFormatter()
  formatter.unitsStyle = .full

  // get exampleDate relative to the current date
  let relativeDate = formatter.localizedString(for: exampleDate, relativeTo: Date())
  
  return relativeDate
}


