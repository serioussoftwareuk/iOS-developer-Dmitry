//
//  PerfomanceChartRouter.swift
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

@objc protocol PerfomanceChartRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol PerfomanceChartDataPassing {
    var dataStore: PerfomanceChartDataStore? { get }
}

class PerfomanceChartRouter: NSObject, PerfomanceChartRoutingLogic, PerfomanceChartDataPassing {
    weak var viewController: PerfomanceChartViewController?
    var dataStore: PerfomanceChartDataStore?

    // MARK: Routing

//    func routeToSomewhere(segue: UIStoryboardSegue?) {
//        if let segue = segue {
//            let destinationVC = segue.destination as! SomewhereViewController
//            var destinationDS = destinationVC.router!.dataStore!
//            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        } else {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//            var destinationDS = destinationVC.router!.dataStore!
//            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//            navigateToSomewhere(source: viewController!, destination: destinationVC)
//        }
//    }

    // MARK: Navigation

//    func navigateToSomewhere(source: PerfomanceChartViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }

    // MARK: Passing data

//    func passDataToSomewhere(source: PerfomanceChartDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
}
