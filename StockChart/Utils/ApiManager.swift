//
//  ApiManager.swift
//  StockChart
//
//  Created by Dmitry Kuklin on 27/07/2020.
//  Copyright © 2020 DK. All rights reserved.
//

import Foundation

fileprivate class ApiCommonManager {
    static let shared = ApiCommonManager()
    
    func sendRequest(_ fileName: String, failure: @escaping (NSError?) -> Void, resultHandler: @escaping ([String: Any]) -> Void) {

        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                if let json = try?  JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any] {
                    resultHandler(json)
                } else {
                    let str = String(decoding: data, as: UTF8.self)
                    print(str)
                    failure(nil)
                }
              } catch {
                //TODO: handle error
                failure(nil)
              }
        }
    }
}

class ApiManager {
    static let shared = ApiManager()

    // MARK: - GET requests

    func getMonthData(success:@escaping ([QuoteSymbols]) -> Void, failure: @escaping (NSError?) -> Void) {
        let fileName = "responseQuotesMonth"
        ApiCommonManager.shared.sendRequest(fileName, failure: { (error) in
            failure(error)
        }) { (json) in
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let decoder = JSONDecoder()
                let response = try decoder.decode(Status.self, from: jsonData)
                let stocksData = response.content.quoteSymbols
                success(stocksData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getWeekData(success:@escaping ([QuoteSymbols]) -> Void, failure: @escaping (NSError?) -> Void) {
        let fileName = "responseQuotesWeek"
        ApiCommonManager.shared.sendRequest(fileName, failure: { (error) in
            failure(error)
        }) { (json) in
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let decoder = JSONDecoder()
                let response = try decoder.decode(Status.self, from: jsonData)
                let stocksData = response.content.quoteSymbols
                success(stocksData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

