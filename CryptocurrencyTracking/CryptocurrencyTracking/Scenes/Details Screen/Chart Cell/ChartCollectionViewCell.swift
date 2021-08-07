//
//  ChartCollectionViewCell.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 05/08/2021.
//

import UIKit
import Reusable
import Charts
import RxSwift
import RxCocoa

final class ChartCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var lineChart: LineChartView!
    @IBOutlet private weak var timeSegments: UISegmentedControl!
    
    private let timePeriods = ["24h", "7d", "30d", "3m", "1y", "5y"]
    var timeSegmentsChanged: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        
    }
    
    private func configureChartView(sparkline: [String]) {
        var entries = [ChartDataEntry]()
        let sparklineDouble = sparkline.map { string -> Double in
            guard let double = Double(string) else { return 0 }
            return double
        }
        var index = 0
        while index < sparklineDouble.count {
            entries.append(ChartDataEntry(x: Double(index),
                                          y: sparklineDouble[index]))
            index += 1
        }
        
        let set = LineChartDataSet(entries: entries)
        set.do {
            $0.setColor(.gray)
            $0.drawCirclesEnabled = false
            $0.drawCircleHoleEnabled = false
            $0.mode = .linear
            $0.lineWidth = 2
            $0.fill = Fill(color: #colorLiteral(red: 0.5605742986, green: 0.5816987158, blue: 0.5818106031, alpha: 1))
            $0.fillAlpha = 1
            $0.fill = Fill.fillWithLinearGradient(initGradientColor()!, angle: 90.0)
            $0.drawFilledEnabled = true
        }
        
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        lineChart.do {
            $0.data = data
            $0.animate(xAxisDuration: 1.2)
            $0.rightAxis.enabled = false
            $0.xAxis.labelPosition = .bottom
            $0.xAxis.enabled = false
            $0.legend.enabled = false
        }
    }
    
    private func initGradientColor() -> CGGradient? {
        let gradientColors = [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor,
                              #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).cgColor,
                              #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1).cgColor,
                              #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1).cgColor,
                              #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor,
                              #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1).cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.5, 0.4, 0.2, 0.03, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                       colors: gradientColors,
                                       locations: colorLocations)
        return gradient
        
    }
    
    @IBAction func didTapChangeValue(_ sender: UISegmentedControl) {
        timeSegmentsChanged?(timePeriods[sender.selectedSegmentIndex])
    }
    
    public func configureCell(history: Driver<[HistoryModel]>) {
        history
            .asObservable()
            .bind { [weak self] (history) in
                let sparkline = history.map { $0.price }
                self?.configureChartView(sparkline: sparkline)
            }
            .disposed(by: rx.disposeBag)
    }
}
