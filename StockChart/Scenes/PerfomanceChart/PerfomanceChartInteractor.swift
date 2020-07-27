//
//  PerfomanceChartInteractor.swift
//  StockChart
//
//  Created by Dmitry Kuklin on 27/07/2020.
//  Copyright (c) 2020 DK. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PerfomanceChartBusinessLogic {
    func onViewDidLoad()
    func onWeekPressed()
    func onMonthPressed()
}

protocol PerfomanceChartDataStore {
}

class PerfomanceChartInteractor: PerfomanceChartBusinessLogic, PerfomanceChartDataStore {
    var presenter: PerfomanceChartPresentationLogic?
    var worker: PerfomanceChartWorker?

    // MARK: Do something

    func onViewDidLoad() {
        worker = PerfomanceChartWorker()
        worker?.getWeekStockData(completionHandler: { [weak self] (stocks) in
            let response = PerfomanceChart.Stocks.Response(stocksPerfomance: stocks)
            self?.presenter?.presentStocks(response: response)
        }, failure: { [weak self] (error) in
            self?.presenter?.presentError()
        })
    }
    
    func onWeekPressed() {
        worker = PerfomanceChartWorker()
        worker?.getWeekStockData(completionHandler: { [weak self] (stocks) in
            let response = PerfomanceChart.Stocks.Response(stocksPerfomance: stocks)
            self?.presenter?.presentStocks(response: response)
        }, failure: { [weak self] (error) in
            self?.presenter?.presentError()
        })
    }
    
    func onMonthPressed() {
        worker = PerfomanceChartWorker()
        worker?.getMonthStockData(completionHandler: { [weak self] (stocks) in
            let response = PerfomanceChart.Stocks.Response(stocksPerfomance: stocks)
            self?.presenter?.presentStocks(response: response)
        }, failure: { [weak self] (error) in
            self?.presenter?.presentError()
        })
    }
}
