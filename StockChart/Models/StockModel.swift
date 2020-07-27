//
//  StockModel.swift
//  StockChart
//
//  Created by Dmitry Kuklin on 27/07/2020.
//  Copyright © 2020 DK. All rights reserved.
//

import Foundation
struct Status: Codable {
    let status: String
    let content: Content
}

struct Content: Codable {
    var quoteSymbols: [QuoteSymbols]
}

class QuoteSymbols: Codable {
    var symbol: String
    var timestamps: [Double]
    var opens: [Double]
    var closures: [Double]
    var highs: [Double]
    var lows: [Double]
    var volumes: [Double]
}
