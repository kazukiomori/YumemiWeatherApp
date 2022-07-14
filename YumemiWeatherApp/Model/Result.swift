//
//  Result.swift
//  YumemiWeatherApp
//
//  Created by Kazuki Omori on 2022/07/15.
//

import Foundation

struct Result: Codable {
    var max_temperature: Int
    var date: String
    var min_temperature: Int
    var weather_condition: String
}
