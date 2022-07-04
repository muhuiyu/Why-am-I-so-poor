//
//  AppTime.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

struct AppTime {
    var year: Int
    var month: Int
    var day: Int
    var hour: Int
    var minute: Int
}

extension AppTime {
    var toString: String {
        return "\(month) \(day), \(hour):\(minute)"
    }
}
