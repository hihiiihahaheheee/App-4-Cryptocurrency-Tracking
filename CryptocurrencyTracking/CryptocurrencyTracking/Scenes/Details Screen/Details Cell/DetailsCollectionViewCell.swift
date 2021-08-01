//
//  DetailsCollectionViewCell.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 01/08/2021.
//

import UIKit
import Reusable
import SDWebImageSVGCoder
import Charts

final class DetailsCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var changeLabel: UILabel!
    @IBOutlet private weak var lineChart: LineChartView!

    @IBOutlet private weak var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        changeLabel.textColor = .white
        changeLabel.layer.cornerRadius = 10
        changeLabel.layer.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }
    
    private func configureChart(sparkline: [String]) {
        
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
    
    public func configureCell(details: CoinDetailsModel) {
        let iconUrl = URL(string: details.iconUrl)
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        iconImage.sd_setImage(with: iconUrl)
        
        nameLabel.text = details.name
        priceLabel.text = details.price.formatPrice(price: details.price)
        changeLabel.text = details.change.formatChange(change: details.change)
        let isIncreased = details.change.formatChange(change: details.change).first != "-"
        let increasedColor: CGColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        let declinedColor: CGColor = #colorLiteral(red: 0.7363152075, green: 0.1033338742, blue: 0.1612970396, alpha: 1)
        changeLabel.layer.backgroundColor = isIncreased ? increasedColor : declinedColor
        configureChart(sparkline: details.sparkline)
    }
}
