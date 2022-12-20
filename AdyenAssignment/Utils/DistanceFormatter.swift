//
//  DistanceFormatter.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import Foundation

struct DistanceFormatter {
    static func formattedDistanceAway(distanceInMeters: Int) -> String {
        if distanceInMeters < 1000 {
            return "\(distanceInMeters)m away"
        } else {
            let distance = Double(distanceInMeters) / 1000.00
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.decimal
            formatter.decimalSeparator = ","
            formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
            formatter.maximumFractionDigits = 1
            let distanceInKm = formatter.string(from: distance as NSNumber) ?? "?"
            return "\(distanceInKm)km away"
        }
    }
}
