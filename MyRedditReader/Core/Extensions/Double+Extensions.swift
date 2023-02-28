//
//  Double+Extensions.swift
//  MyRedditReader
//
//  Created by Нікіта Боровік on 28.02.2023.
//

import Foundation

extension Double{
    var makeTimeString: String {
        let timePassed = Date().timeIntervalSince1970 - TimeInterval(self)
        let dateFormater = DateComponentsFormatter()
        dateFormater.unitsStyle = .abbreviated
        dateFormater.maximumUnitCount = 1
        dateFormater.calendar?.locale = Locale(identifier: "en")
        dateFormater.allowedUnits = [.second,.minute,.hour,.day]
        let res = dateFormater.string(from: timePassed) ?? String(timePassed)
        return res
    }
}
