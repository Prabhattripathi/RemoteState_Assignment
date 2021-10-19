//
//  TruckModel.swift
//  RemoteState_Assignment
//
//  Created by Prabhat on 18/10/21.
//

import Foundation

// MARK: - TruckModel
struct TruckModel: Codable {
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let truckNumber: String?
    let createTime: Int?
    let lastWaypoint: LastWaypoint?
    let lastRunningState: LastRunningState?

    enum CodingKeys: String, CodingKey {
        case id
        case truckNumber
        case createTime, lastWaypoint, lastRunningState
    }
}

// MARK: - LastRunningState
struct LastRunningState: Codable {
    let stopStartTime, truckRunningState: Int?

    enum CodingKeys: String, CodingKey {
        case stopStartTime, truckRunningState
    }
}

// MARK: - LastWaypoint
struct LastWaypoint: Codable {
    let lat, lng: Double?
    let createTime: Int?
    let speed: Double?
    let ignitionOn: Bool?

    enum CodingKeys: String, CodingKey {
        case lat, lng, createTime
        case speed, ignitionOn
    }
}
