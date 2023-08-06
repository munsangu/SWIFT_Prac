import UIKit
import DGCharts

class ResultOfTurtleViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var turtlePercentLabel: UILabel!
    
    @IBOutlet weak var chartContainerView: UIView!
    var pieChart = PieChartView()
    var resultOfPercentage = UserDefaults.standard.float(forKey: "turtlePercentage") // 0 ~ 100

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 16
        pieChart.delegate = self
        turtlePercentLabel.text = "\(String(Int(resultOfPercentage * 100)))%"
        
        self.configurePieChart()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.updatePieChartFrame()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let finalCheckTurtleViewController = self.storyboard?.instantiateViewController(withIdentifier: "finalCheckTurtleViewController") {
            finalCheckTurtleViewController.modalPresentationStyle = .fullScreen
            self.present(finalCheckTurtleViewController, animated: false)
        }
    }
    
    private func updatePieChartFrame() {
        guard chartContainerView != nil else {
            return
        }
        
        pieChart.frame = CGRect(x: 0, y: 0, width: chartContainerView.frame.size.width, height: chartContainerView.frame.size.width)
        pieChart.center = chartContainerView.center
        view.addSubview(pieChart)
    }
    
    func configurePieChart() {
        
        let dataEntries = [
            PieChartDataEntry(value: Double(resultOfPercentage * 100)),
            PieChartDataEntry(value: Double(100 - (resultOfPercentage * 100)))
        ]
        
        let dataSet = PieChartDataSet(entries: dataEntries, label: "")
        dataSet.drawValuesEnabled = false
        dataSet.colors = [UIColor(cgColor: CGColor(red: 255 / 255, green: 160 / 255, blue: 206 / 255, alpha: 1)), UIColor.clear]
        let data = PieChartData(dataSet: dataSet)
        
        pieChart.data = data
        pieChart.legend.enabled = false
                
        pieChart.animate(xAxisDuration: 3, yAxisDuration: 3)
        
        dataEntries[0].value = Double(resultOfPercentage * 100)
        pieChart.notifyDataSetChanged()
        
    }
        
}
