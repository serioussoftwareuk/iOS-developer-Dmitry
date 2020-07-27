//
//  Int+Extencsion.swift
//  StockChart
//
//  Created by Dmitry Kuklin on 27/07/2020.
//  Copyright © 2020 DK. All rights reserved.
//

import UIKit

extension Double {
    func timestampToStringDateHours() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMMM dd \n HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func timestampToStringDate() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMMM dd"
        return dateFormatter.string(from: date)
    }
}
