//
//  PerfomanceChartViewController.swift
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

protocol PerfomanceChartDisplayLogic: class {
    func displayStocks(viewModel: PerfomanceChart.Stocks.ViewModel)
    func displayError()
}

class PerfomanceChartViewController: UIViewController, PerfomanceChartDisplayLogic {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stockNameOne: UILabel!
    @IBOutlet weak var stockNameTwo: UILabel!
    @IBOutlet weak var stockNameThree: UILabel!
    
    var interactor: PerfomanceChartBusinessLogic?
    var router: (NSObjectProtocol & PerfomanceChartRoutingLogic & PerfomanceChartDataPassing)?

    fileprivate let stepSpacerHorizont = 60
    fileprivate let stepSpacerVertical = 10
    
    fileprivate let colors = [UIColor.blue.cgColor, UIColor.green.cgColor, UIColor.orange.cgColor]
    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = PerfomanceChartInteractor()
        let presenter = PerfomanceChartPresenter()
        let router = PerfomanceChartRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
        interactor?.onViewDidLoad()
    }

    // MARK: Do something

    func displayError() {
        let alert = UIAlertController(title: "Error", message: "User canceled SigIn process", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func displayStocks(viewModel: PerfomanceChart.Stocks.ViewModel) {
        for view in scrollView.subviews {
            view.removeFromSuperview()
        }
        
        for layer in scrollView.layer.sublayers ?? [CALayer]() {
            layer.removeFromSuperlayer()
        }
        
        drawLinesCoordinate(pointsH: viewModel.stocksPerfomance[0].performancePoints.count, dates: viewModel.stocksPerfomance[0].dates)
        
        stockNameOne.text = viewModel.stocksPerfomance[0].stockName
        stockNameTwo.text = viewModel.stocksPerfomance[1].stockName
        stockNameThree.text = viewModel.stocksPerfomance[2].stockName
        
        for i in 0..<viewModel.stocksPerfomance.count {
            let stock = viewModel.stocksPerfomance[i]
            drawGraphic(values: stock.performancePoints, color: colors[i])
        }
    }
    
    @IBAction func monthPressed(_ sender: UIButton) {
        interactor?.onMonthPressed()
    }
    
    @IBAction func weekPressed(_ sender: UIButton) {
        interactor?.onWeekPressed()
    }
}

private extension PerfomanceChartViewController {
    func uiSetup() {
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: 1)
    }
    
    func drawLinesCoordinate(pointsH: Int, dates: [String]) {
        let width = (pointsH * stepSpacerHorizont) + stepSpacerHorizont
        scrollView.contentSize = CGSize(width: width, height: 1)
        
        var x = stepSpacerHorizont
        let height = scrollView.frame.size.height
        
        let middleLineLine = UIView(frame: CGRect(x: x, y: Int(height / 2), width: Int(scrollView.contentSize.width - CGFloat(stepSpacerHorizont)), height: 1))
        middleLineLine.backgroundColor = UIColor.lightGray
        scrollView.addSubview(middleLineLine)
               
        for i in 0..<dates.count {
            let pointLine = UIView(frame: CGRect(x: x, y: 0, width: 1, height: Int(height - 30)))
            pointLine.backgroundColor = UIColor.lightGray
            scrollView.addSubview(pointLine)
            
            let label = UILabel()
            label.numberOfLines = 0
            
            let array = dates[i].components(separatedBy: "\n")
            if array.count > 1 {
                label.text = "\(array[0]) \n \(array[1])"
            } else {
                label.text = dates[i]
            }
            
            label.font = UIFont.systemFont(ofSize: 10.0, weight: .medium)
            label.sizeToFit()

            let width = label.frame.size.width
            label.frame = CGRect(x: (CGFloat(x) - ( width / 2)), y: scrollView.frame.size.height - 24, width: width, height: label.frame.size.height)
            scrollView.addSubview(label)
            x = x + stepSpacerHorizont + 1
       }
    }
    
    func drawGraphic(values: [Double], color: CGColor) {
        let yZero = scrollView.frame.size.height / 2
        var x: CGFloat = 0
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x, y: yZero))
        
        for value in values {
            x = x + CGFloat(stepSpacerHorizont)
            path.addLine(to: CGPoint(x: x, y: yZero + CGFloat(Double(stepSpacerVertical) * value)))
        }

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2

        scrollView.layer.addSublayer(shapeLayer)
    }
}
