//
//  LiveTrackingViewController.swift
//  AirQuality
//
//  Created by Srikanth SP on 10/05/22.
//

import UIKit
import Charts

class CityLiveView: UIViewController, CityLiveViewProtocol {
    
    private let AXIS_LINE_COLOR = UIColor(red: 34/255, green: 35/255, blue: 38/255, alpha: 1.0)
    private let AXIS_TEXT_COLOR = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.9)
    
    private var chartData = [CityLiveAQIModel]()
    var presenter: CityLivePresenterProtocol?
    
    private var lineChartView = LineChartView()
    private var selectedCity: String!
    
    @IBOutlet weak var chartContainer: UIStackView!
        override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChartView()
        presenter?.viewDidLoad()
        
        addMockData()
    }
    
    func addMockData() {
        
        let model1 = CityLiveAQIModel()
        model1.city = "Pune"
        model1.aqi = 100.0
        model1.time = Date.init(timeIntervalSinceNow: -500.0)
        
        
        let model2 = CityLiveAQIModel()
        model2.city = "Pune"
        model2.aqi = 100.0
        model2.time = Date.init(timeIntervalSinceNow: -400.0)
        
        let model3 = CityLiveAQIModel()
        model3.city = "Pune"
        model3.aqi = 200.0
        model3.time = Date.init(timeIntervalSinceNow: -300.0)
        
        let model4 = CityLiveAQIModel()
        model4.city = "Pune"
        model4.aqi = 300.0
        model4.time = Date.init(timeIntervalSinceNow: -200.0)
        
        let model5 = CityLiveAQIModel()
        model5.city = "Pune"
        model5.aqi = 400.0
        model5.time = Date.init(timeIntervalSinceNow: -100.0)
        
        let model6 = CityLiveAQIModel()
        model6.city = "Pune"
        model6.aqi = 500.0
        model6.time = Date.init(timeIntervalSinceNow: -10.0)
        
        chartData = [model1,model2,model3,model4,model5,model6]
        
    }
    
    override func viewDidLayoutSubviews() {
        updateChart()
    }

    func configure(cityName: String) {
        selectedCity = cityName
    }
    
    func updateCity(_ result: Result<CityLiveAQIModel, Error>) {
        
        switch result {
        case .success(let data):
            chartData.append(data)
            updateChart()
        
        case .failure(let error):
            throwErrorAlert(title: "Error", text: error.localizedDescription)
        }
    }
    
    func updateChart() {
        var chartEntries = [ChartDataEntry]()
        
        for value in chartData {
            if let date = value.time, let aqi =  value.aqi {
                chartEntries.append(ChartDataEntry(x: date.timeIntervalSince1970, y: aqi))
            }
        }
        
        let dataSet = LineChartDataSet(entries: chartEntries)
        let data = LineChartData(dataSets: [dataSet])
        lineChartView.data = data
        lineChartView.chartDescription.text = "Air Quality Index"
        lineChartView.notifyDataSetChanged()
        
    }
    
    func updateLoadingStatus(_ isLoading: Bool) {
        
    }
    
    func setupChartView() {

        lineChartView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.chartContainer.addArrangedSubview(lineChartView)
        
        if let selectedCity = selectedCity {
            title = selectedCity
        }
        
        // Set Chart x-Axis and left-Axis
        let xAxis = lineChartView.xAxis
        xAxis.gridColor = .clear
        xAxis.labelPosition = .bottom
        
        let leftAxis = lineChartView.leftAxis
        leftAxis.gridColor = .clear
        
        xAxis.labelTextColor = .blue
        leftAxis.labelTextColor = .black
        xAxis.axisLineColor = .darkGray
        leftAxis.axisLineColor = .darkGray
        
        
        // Set x-Asis formatter
        xAxis.granularity = 7
        xAxis.axisMaxLabels = 4
        xAxis.valueFormatter = DateValueFormatter()
        
        // Hide right-Axis
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.form = .line
        
    }
}
